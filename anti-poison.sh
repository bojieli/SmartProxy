#/bin/sh
iptables -N anti_poison
iptables -F anti_poison
iptables -D INPUT -p udp --sport 53 -j anti_poison
iptables -I INPUT -p udp --sport 53 -j anti_poison
iptables -D FORWARD -p udp --sport 53 -j anti_poison
iptables -I FORWARD -p udp --sport 53 -j anti_poison
iptables -I anti_poison -m string --algo bm --hex-string "|4A7D7F66|" -j DROP
iptables -I anti_poison -m string --algo bm --hex-string "|4A7D9B66|" -j DROP
iptables -I anti_poison -m string --algo bm --hex-string "|4A7D2766|" -j DROP
iptables -I anti_poison -m string --algo bm --hex-string "|4A7D2771|" -j DROP
iptables -I anti_poison -m string --algo bm --hex-string "|BDA31105|" -j DROP
iptables -I anti_poison -m string --algo bm --hex-string "|D155E58A|" -j DROP
iptables -I anti_poison -m string --algo bm --hex-string "|F9812E30|" -j DROP
iptables -I anti_poison -m string --algo bm --hex-string "|80797E8B|" -j DROP
iptables -I anti_poison -m string --algo bm --hex-string "|9F6A794B|" -j DROP
iptables -I anti_poison -m string --algo bm --hex-string "|A9840D67|" -j DROP
iptables -I anti_poison -m string --algo bm --hex-string "|C043C606|" -j DROP
iptables -I anti_poison -m string --algo bm --hex-string "|CA6A0102|" -j DROP
iptables -I anti_poison -m string --algo bm --hex-string "|CAB50755|" -j DROP
iptables -I anti_poison -m string --algo bm --hex-string "|CBA1E6AB|" -j DROP
iptables -I anti_poison -m string --algo bm --hex-string "|CB620741|" -j DROP
iptables -I anti_poison -m string --algo bm --hex-string "|CF0C5862|" -j DROP
iptables -I anti_poison -m string --algo bm --hex-string "|D0381F2B|" -j DROP
iptables -I anti_poison -m string --algo bm --hex-string "|D1913632|" -j DROP
iptables -I anti_poison -m string --algo bm --hex-string "|D1DC1EAE|" -j DROP
iptables -I anti_poison -m string --algo bm --hex-string "|D1244921|" -j DROP
iptables -I anti_poison -m string --algo bm --hex-string "|D35E4293|" -j DROP
iptables -I anti_poison -m string --algo bm --hex-string "|D5A9FB23|" -j DROP
iptables -I anti_poison -m string --algo bm --hex-string "|D8DDBCB6|" -j DROP
iptables -I anti_poison -m string --algo bm --hex-string "|D8EAB30D|" -j DROP
iptables -I anti_poison -m string --algo bm --hex-string "|F3B9BB27|" -j DROP
iptables -I anti_poison -m string --algo bm --hex-string "|253D369E|" -j DROP
iptables -I anti_poison -m string --algo bm --hex-string "|042442B2|" -j DROP
iptables -I anti_poison -m string --algo bm --hex-string "|2E52AE44|" -j DROP
iptables -I anti_poison -m string --algo bm --hex-string "|3B1803AD|" -j DROP
iptables -I anti_poison -m string --algo bm --hex-string "|402158A1|" -j DROP
iptables -I anti_poison -m string --algo bm --hex-string "|4021632F|" -j DROP
iptables -I anti_poison -m string --algo bm --hex-string "|4042A3FB|" -j DROP
iptables -I anti_poison -m string --algo bm --hex-string "|4168CAFC|" -j DROP
iptables -I anti_poison -m string --algo bm --hex-string "|41A0DB71|" -j DROP
iptables -I anti_poison -m string --algo bm --hex-string "|422DFCED|" -j DROP
iptables -I anti_poison -m string --algo bm --hex-string "|480ECD68|" -j DROP
iptables -I anti_poison -m string --algo bm --hex-string "|480ECD63|" -j DROP
iptables -I anti_poison -m string --algo bm --hex-string "|4E10310F|" -j DROP
iptables -I anti_poison -m string --algo bm --hex-string "|0807C62D|" -j DROP
iptables -I anti_poison -m string --algo bm --hex-string "|5D2E0859|" -j DROP
iptables -I anti_poison -m string --algo bm --hex-string "|FD9D0EA5|" -j DROP
iptables -I anti_poison -m string --algo bm --hex-string "|364C8701|" -j DROP
iptables -I anti_poison -m string --algo bm --hex-string "|1759053C|" -j DROP
iptables -I anti_poison -m string --algo bm --hex-string "|31027B38|" -j DROP
iptables -I anti_poison -m string --algo bm --hex-string "|4D04075C|" -j DROP
iptables -I anti_poison -m string --algo bm --hex-string "|C504040C|" -j DROP
iptables -I anti_poison -m string --algo bm --hex-string "|76053106|" -j DROP
iptables -I anti_poison -m string --algo bm --hex-string "|BC050460|" -j DROP
iptables -I anti_poison -m string --algo bm --hex-string "|BDA31105|" -j DROP
