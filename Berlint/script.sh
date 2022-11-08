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
' > /etc/squid/squid.conf

echo '
acl AVAILABLE_WORKING time AS 00:00-23:59
acl AVAILABLE_WORKING time MTWHF 00:00-07:59
acl AVAILABLE_WORKING time MTWHF 17:00-23:59
acl OUT_WORKING dstdomain .loid-work.com .ranky-work.com
' > /etc/squid/acl.conf

service squid restart