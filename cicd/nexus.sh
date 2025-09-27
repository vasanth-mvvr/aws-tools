#!/bin/bash
yum install java-17-openjdk -y

mkdir /app
cd /app

curl -L -o nexus.tar.gz https://sonatype-download.global.ssl.fastly.net/repository/downloads-prod-group/3/nexus-3.84.0-03-linux-x86_64.tar.gz

file nexus.tar.gz

tar -xvf nexus.tar.gz

mv nexus-3* nexus

adduser nexus

chown -R nexus:nexus /app/nexus
chown -R nexus:nexus /app/sonatype-work

vim  /app/nexus/bin/nexus.rc
run_as_user="nexus"

vim /etc/systemd/system/nexus.service
[Unit]
Description=nexus service
After=network.target

[Service]
Type=forking
LimitNOFILE=65536
User=nexus
Group=nexus
ExecStart=/app/nexus/bin/nexus start
ExecStop=/app/nexus/bin/nexus stop
User=nexus
Restart=on-abort

[Install]
WantedBy=multi-user.target

chkconfig nexus on

systemctl start nexus