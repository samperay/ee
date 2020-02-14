resource "aws_vpc" "infra-vpc" {
  cidr_block       = "172.20.0.0/16"
  instance_tenancy = "default"
  enable_dns_hostnames = "true"

  tags = {
    Name = "infra-vpc"
  }
}

// Creating Public Subnet, IGW, route and its associations

resource "aws_subnet" "jenkins-public-subnet" {
  vpc_id                  = "${aws_vpc.infra-vpc.id}"
  cidr_block              = "172.20.10.0/24"
  availability_zone       = "ap-south-1a"
  map_public_ip_on_launch = "true"

  tags = {
    Name = "jenkins-public-subnet"
  }
}

resource "aws_internet_gateway" "infra-igw" {
  vpc_id = "${aws_vpc.infra-vpc.id}"

  tags = {
    Name = "infra-igw"
  }
}

resource "aws_route_table" "jenkins-public-route" {
  vpc_id = "${aws_vpc.infra-vpc.id}"

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = "${aws_internet_gateway.infra-igw.id}"
  }

  tags = {
    Name = "jenkins-public-route"
  }

}

resource "aws_route_table_association" "public-route-table-association" {
  subnet_id      = "${aws_subnet.jenkins-public-subnet.id}"
  route_table_id = "${aws_route_table.jenkins-public-route.id}"
}


// Creating Private Subnet, NAT Gateway, route and its associations
resource "aws_eip" "eip-nat" {
  vpc = true
}

resource "aws_nat_gateway" "infra-natgw" {
  allocation_id = "${aws_eip.eip-nat.id}"
  subnet_id     = "${aws_subnet.jenkins-public-subnet.id}"

  tags = {
    Name = "infra-natgw"
  }
}

resource "aws_subnet" "tomcat-private-subnet" {
  vpc_id            = "${aws_vpc.infra-vpc.id}"
  cidr_block        = "172.20.20.0/24"
  availability_zone = "ap-south-1a"

  tags = {
    Name = "tomcat-private-subnet"
  }
}

resource "aws_route_table" "tomcat-route-private-gw" {
  vpc_id = "${aws_vpc.infra-vpc.id}"

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = "${aws_nat_gateway.infra-natgw.id}"
  }

  tags = {
    Name = "tomcat-route-private-gateway"
  }
}

resource "aws_route_table_association" "tomcat-route-private-association" {
  subnet_id      = "${aws_subnet.tomcat-private-subnet.id}"
  route_table_id = "${aws_route_table.tomcat-route-private-gw.id}"
}




