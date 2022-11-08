echo '
auto eth0
iface eth0 inet static
	address 10.10.2.4
	netmask 255.255.255.0
	gateway 10.10.2.1
' > /etc/network/interfaces

echo '
nameserver 192.168.122.1
' > /etc/resolv.conf

apt-get update

apt-get install isc-dhcp-server -y

echo '
INTERFACES="eth0"
' > /etc/default/isc-dhcp-server

echo '
subnet 10.10.2.0 netmask 255.255.255.0 {
}

subnet 10.10.1.0 netmask 255.255.255.0 {
    range 10.10.1.50 10.10.1.88;
    range 10.10.1.120 10.10.1.155;
    option routers 10.10.1.1;
    option broadcast-address 10.10.1.255;
    option domain-name-servers 10.10.2.2;
    default-lease-time 300;
    max-lease-time 6900;
}

subnet 10.10.3.0 netmask 255.255.255.0 {
    range 10.10.3.10 10.10.3.30;
    range 10.10.3.60 10.10.3.85;
    option routers 10.10.3.1;
    option broadcast-address 10.10.3.255;
    option domain-name-servers 10.10.2.2;
    default-lease-time 600;
    max-lease-time 6900;
}
' > /etc/dhcp/dhcpd.conf

service isc-dhcp-server restart