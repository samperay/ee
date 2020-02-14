#!/bin/bash

echo "Install epel repo"
sudo yum install epel-release -y

echo "Install Ansible"
sudo yum update ansible -y

echo "Install Java JDK 8, maven, git"
sudo yum remove -y java
sudo yum install -y java-1.8.0-openjdk maven git docker
sudo usermod -a -G dockerroot ec2-user
sudo systemctl start docker
sudo systemctl enable docker
sudo chkconfig docker on
