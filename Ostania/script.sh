# auto eth0
# iface eth0 inet dhcp

# auto eth1
# iface eth1 inet static
# 	address 10.10.1.1
# 	netmask 255.255.255.0

# auto eth2
# iface eth2 inet static
# 	address 10.10.2.1
# 	netmask 255.255.255.0

# auto eth3
# iface eth3 inet static
# 	address 10.10.3.1
# 	netmask 255.255.255.0

iptables -t nat -A POSTROUTING -o eth0 -j MASQUERADE -s 10.10.0.0/16

apt-get update
wait 

apt-get install isc-dhcp-relay -y
wait

echo '
# What servers should the DHCP relay forward requests to?
SERVERS="10.10.2.4"

# On what interfaces should the DHCP relay (dhrelay) serve DHCP requests?
INTERFACES="eth1 eth2 eth3"

# Additional options that are passed to the DHCP relay daemon?
OPTIONS=
' > /etc/default/isc-dhcp-relay

echo '
net.ipv4.ip_forward=1
' > /etc/sysctl.conf

service isc-dhcp-relay restart