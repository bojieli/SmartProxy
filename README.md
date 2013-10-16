SmartProxy
----------

If you have two machines in different ISPs, this tool can be used to make one of them as server and the other as client, and route through different ISPs according to IP range table of ISPs.

The scripts are dedicated for USTC LUG server network. To use them in your own network, you have to modify the params according to the comments.

The ultimate goal of this project is to build a generic tool for adaptive proxy tunnel selection. It is hard, but the conversation can begin.


For blog.ustc.edu.cn Maintainers
--------------------------------

blog server should run scripts in blog-specific dir:

* ```ip-route``` and ```ip-rules``` should be in rc.local
* ```iptables-save``` should be inserted to iptables by iptables-restore in rc.local (therefore if you modify iptables rules, please also update this file using iptables-save command)
* ```abroad-route``` should be run after OpenVPN is connected to abroad server (see /etc/openvpn/*.conf)
