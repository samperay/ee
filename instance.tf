// Get default AWS Creds from ~/.aws/credentials for default profile

provider "aws" {
  profile = "default"
  region  = "ap-south-1"
}

// Get latest CentOS 7 Image
data "aws_ami" "centos" {
  owners      = ["679593333241"]
  most_recent = true

  filter {
    name   = "name"
    values = ["CentOS Linux 7 x86_64 HVM EBS *"]
  }

  filter {
    name   = "architecture"
    values = ["x86_64"]
  }

  filter {
    name   = "root-device-type"
    values = ["ebs"]
  }
}

// Creating Jenkins Instance

resource "aws_key_pair" "jenkins-keypair" {
  key_name   = "${var.JENKINS_PRIVATE_KEY}"
  public_key = "${file("${var.JENKINS_PUBLIC_KEY}")}"
}

resource "aws_instance" "jenkins-instance" {
  ami                    = "${data.aws_ami.centos.id}"
  instance_type          = "t2.medium"
  key_name               = "${var.JENKINS_PRIVATE_KEY}"
  vpc_security_group_ids = ["${aws_security_group.jenkins-sg.id}"]
  subnet_id              = "${aws_subnet.jenkins-public-subnet.id}"
  user_data              = "${file("scripts/install_jenkins.sh")}"

  tags = {
    Name = "jenkins"
  }
}

output "jenkins-public-ip" {
  value = "${aws_instance.jenkins-instance.public_ip}"
}

// Creating Tomcat Instance

resource "aws_key_pair" "tomcat-keypair" {
   key_name   = "${var.TOMCAT_PRIVATE_KEY}"
   public_key = "${file("${var.TOMCAT_PUBLIC_KEY}")}"
 }

resource "aws_instance" "tomcat-instance" {
   ami                    = "${data.aws_ami.centos.id}"
   instance_type          = "t2.micro"
   key_name               = "${var.TOMCAT_PRIVATE_KEY}"
   vpc_security_group_ids = ["${aws_security_group.tomcat-sg.id}"]
   subnet_id              = "${aws_subnet.tomcat-private-subnet.id}"
   user_data              = "${file("scripts/install_apps.sh")}"

   tags = {
     Name = "tomcat"
   }
}

output "tomcat-private-ip" {
   value = "${aws_instance.tomcat-instance.private_ip}"
}
