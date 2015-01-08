#!/bin/bash
## This script should be run every minute. If it cannot access a test site via GRE tunnel within 5 trials, the default route will be switched off GRE tunnel (to ISP route). If the test site is available again via GRE tunnel in 3 consecutive minutes, switch to it and restart "bind9".

cd $(dirname $0)

function getgw() {
    ip route get 8.8.8.8 | head -n 1 | awk '{print $3}'
}
gw=$(getgw)
[ -z "$gw" ] && exit 1

if [ "$gw" = "10.0.2.1" ]; then
# tunnel is enabled
    # if fail for all 5 trials...
    for i in {1..5}; do
        curl -4 --connect-timeout 10 --max-time 30 http://googleblog.blogspot.com/ >/dev/null 2>&1 && exit 0
    done
    # in case other probes have switched off the tunnel... double check
    if [ "$(getgw)" = "10.0.2.1" ]; then
        [ -x "./try-reboot-vps" ] && ./try-reboot-vps

        sleep 10 # give time for VPS to reboot
        # if it recovers, do not switch off tunnel
        for i in {1..2}; do
            curl -4 --connect-timeout 10 --max-time 30 http://googleblog.blogspot.com/ >/dev/null 2>&1 && exit 0
        done

        # switch off default route from tunnel
        export IPV6_GRE_TUNNEL_ENABLE=false
        export IPV4_GRE_TUNNEL_ENABLE=false
        output=$(./ip-route)
        /etc/init.d/bind9 restart  ## clean DNS negative cache
        mutt -s "VPN tunnel test failed" -- "servmon@blog.ustc.edu.cn" <<EOF
Tunnel switched off.
Output: $output
EOF
    fi
else
# tunnel is disabled
    # try reboot vps dirst!
    [ -x "./try-reboot-vps" ] && ./try-reboot-vps

    # if succeed for all 5 trials...
    for i in {1..5}; do
        curl --interface do2 -4 --connect-timeout 10 --max-time 30 http://googleblog.blogspot.com/ >/dev/null 2>&1 || exit 0
        sleep 5
    done
    # in case other probes have switched on the tunnel... double check
    if [ "$(getgw)" != "10.0.2.1" ]; then
        # switch on default route via tunnel
        export IPV6_GRE_TUNNEL_ENABLE=true
        export IPV4_GRE_TUNNEL_ENABLE=true
        output=$(./ip-route)
        /etc/init.d/bind9 restart  ## clean DNS cache which may have been polluted
        mutt -s "VPN tunnel recovered" -- "servmon@blog.ustc.edu.cn" <<EOF
Tunnel switched on.
Output: $output
EOF
    fi
fi
