#!/bin/bash

function gre_replace() {
    tunnel=$1
    real_local=$2
    real_remote=$3
    real_gw=$4
    virt_local=$5

    ip route replace $real_remote/32 via $real_gw
    if [ -z "$(ip tunnel show $tunnel)" ]; then
        ip tunnel add $tunnel mode gre remote $real_remote local $real_local ttl 255
    else
        ip tunnel change $tunnel mode gre remote $real_remote local $real_local ttl 255
    fi
    ip link set $tunnel up
    ip addr add $virt_local dev $tunnel 2>/dev/null  # if duplicate, do not show warning
}

cd $(dirname $0)/conf
gre_replace do2 202.141.176.99 128.199.95.148 202.141.176.126 10.0.3.2/30
gre_replace do2 202.141.176.99 128.199.95.148 202.141.176.126 fdfe:dcba:9876::3:2/126

cat chnroutes.txt | (echo "route flush table 10000"; sed 's/\([ ;#].*\)//g;/^$/d' | awk "{printf(\"route replace %s via 202.141.160.126 table 10000\n\", \$1); }") | ip -batch -
ip rule del from all lookup 10000 2>/dev/null
ip rule add from all lookup 10000 pref 10000
ip route replace default via 10.0.3.1

cat chnroutes-v6.txt | (echo "route flush table 10000"; sed 's/\([ ;#].*\)//g;/^$/d' | awk "{printf(\"route replace %s via 2001:da8:d800:f001::1 table 10000\n\", \$1); }") | ip -6 -batch -
ip -6 rule del from all lookup 10000 2>/dev/null
ip -6 rule add from all lookup 10000 pref 10000
ip -6 route del default
ip -6 route add default via fdfe:dcba:9876::3:1


revproxy_remote="128.199.232.134"
subnet=99
gre_replace revproxy 202.141.176.99 $revproxy_remote 202.141.176.126 10.0.$subnet.2/30
gre_replace revproxy 202.141.176.99 $revproxy_remote 202.141.176.126 fdfe:dcba:9876::$subnet:2/126

function ip_route_revproxy() {
	subnet=$1
	revproxy=$2
	ip route replace default via 10.0.$subnet.1 dev $revproxy table $subnet
	ip rule del fwmark $subnet lookup $subnet pref $subnet
	ip rule add fwmark $subnet lookup $subnet pref $subnet
	ip -6 route add default via fdfe:dcba:9876::$subnet:1 dev $revproxy table $subnet
	ip -6 rule del fwmark $subnet lookup $subnet pref $subnet
	ip -6 rule add fwmark $subnet lookup $subnet pref $subnet
}

ip_route_revproxy 99 revproxy
ip_route_revproxy 3  do2
