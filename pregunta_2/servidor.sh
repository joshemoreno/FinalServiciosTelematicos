#!/bin/sh
sudo -i
yum -y update
yum -y install vim
wget --no-cookies --no-check-certificate --header "Cookie:oraclelicense=accept-securebackup-cookie" "http://download.oracle.com/otn-pub/java/jdk/8u131-b11/d54c1d3a095b4ff2b6607d096fa80163/jdk-8u131-linux-x64.rpm"
yum -y install rpm
yum -y localinstall jdk-8u131-linux-x64.rpm
wget https://github.com/dularion/streama/releases/download/v1.1/streama-1.1.war
mkdir /opt/streama
mv streama-1.1.war /opt/streama/streama.war

mkdir /opt/streama/media
chmod 777 /opt/streama/media
echo '[Unit]' >> /etc/systemd/system/streama.service
echo 'Description=Streama Server' >> /etc/systemd/system/streama.service
echo 'After=syslog.target' >> /etc/systemd/system/streama.service
echo 'After=network.target' >> /etc/systemd/system/streama.service

echo '[Service]' >> /etc/systemd/system/streama.service
echo 'User=root' >> /etc/systemd/system/streama.service
echo 'Type=simple' >> /etc/systemd/system/streama.service
echo 'ExecStart=/bin/java -jar /opt/streama/streama.war' >> /etc/systemd/system/streama.service
echo 'Restart=always' >> /etc/systemd/system/streama.service
echo 'StandardOutput=syslog' >> /etc/systemd/system/streama.service
echo 'StandardError=syslog' >> /etc/systemd/system/streama.service
echo 'SyslogIdentifier=Streama' >> /etc/systemd/system/streama.service

echo '[Install]' >> /etc/systemd/system/streama.service
echo 'WantedBy=multi-user.target' >> /etc/systemd/system/streama.service
systemctl start streama
systemctl enable streama
systemctl status streama
systemctl restart streama
java -jar /opt/streama/streama.war
