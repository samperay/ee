#!/bin/bash

echo "Install Java JDK 8, maven, git, epel, wget"
sudo yum remove -y java
sudo yum install java-1.8.0-openjdk epel-release maven git docker wget -y

echo "importing epel key"
sudo rpm --import /etc/pki/rpm-gpg/RPM-GPG-KEY-EPEL-7

echo "Install Ansible"
sudo yum update ansible -y

echo "Install Jenkins"
sudo wget -O /etc/yum.repos.d/jenkins.repo http://pkg.jenkins-ci.org/redhat-stable/jenkins.repo
sudo rpm --import https://jenkins-ci.org/redhat/jenkins-ci.org.key
sudo yum install -y jenkins
sudo usermod -a -G docker jenkins
sudo systemctl start docker
sudo systemctl start jenkins

echo "Enable jenkins"
sudo sytemctl enable jenkins
sudo systemctl enable docker

echo "Start services after boot"
sudo chkconfig jenkins on
sudo chkconfig docker on
