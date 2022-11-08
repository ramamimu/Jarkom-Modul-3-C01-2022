# auto eth0
# iface eth0 inet dhcp

sleep 5 

apt-get update

apt-get install lynx -y

export http_proxy="http://10.10.2.3:8080"