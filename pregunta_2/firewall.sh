#!/bin/sh

sudo -i
yum -y install vim
service NetworkManager stop
chkconfig NetworkManager off
echo 'net.ipv4.ip_forward = 1' >> /etc/sysctl.conf
service firewalld start
firewall-cmd --zone=dmz --add-interface=eth1 --permanent
firewall-cmd --reload
firewall-cmd --zone=public --add-interface=eth2 --permanent
firewall-cmd --reload
firewall-cmd --set-default-zone=public
firewall-cmd --reload
firewall-cmd --zone=public --add-service=steam-streaming --permanent
firewall-cmd --reload
firewall-cmd --zone=public --add-rich-rule 'rule family=ipv4 forward-port port=8080 protocol=tcp to-port=8080 to-addr=192.168.50.11' --permanent
firewall-cmd --reload
firewall-cmd --zone=dmz --add-masquerade --permanent
firewall-cmd --reload
