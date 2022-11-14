# auto eth0
# iface eth0 inet static
# 	address 10.10.2.3
# 	netmask 255.255.255.0
# 	gateway 10.10.2.1

echo '
nameserver 192.168.122.1
' > /etc/resolv.conf

apt-get update

apt-get install squid -y

mv /etc/squid/squid.conf /etc/squid/squid.conf.bak

echo '
include /etc/squid/acl.conf

http_port 8080
visible_hostname Berlint

http_access allow AVAILABLE_WORKING
http_access allow OUT_WORKING
http_access deny !SSL_ports

delay_pools 1
delay_class 1 2
delay_access 1 allow all !NO_LIMIT_DAYS
delay_parameters 1 none 16000/16000
' > /etc/squid/squid.conf

echo '
acl SSL_ports port 443
acl AVAILABLE_WORKING time AS 00:00-23:59
acl AVAILABLE_WORKING time MTWHF 00:00-07:59
acl AVAILABLE_WORKING time MTWHF 17:00-23:59
acl OUT_WORKING dstdomain .loid-work.com .ranky-work.com
acl NO_LIMIT_DAYS time MTWHF

' > /etc/squid/acl.conf

service squid restart