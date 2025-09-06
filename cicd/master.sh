#!/bin/bash
curl /etc/yum.repos.d/jenkins.repo https://pkg.jenkins.io/redhat-stable/jenkins.repo
rpm --import https://pkg.jenkins.io/redhat-stable/jenkins.io-2023.key
yum install fontconfig java-21-openjdk jenkins -y
systemctl daemon-reload
systemctl enable jenkins
systemctl start jenkins