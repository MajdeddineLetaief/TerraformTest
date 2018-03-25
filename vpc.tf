# Define our VPC
resource "aws_vpc" "default" {
  cidr_block = "${var.vpc_cidr}"
  enable_dns_hostnames = true
  tags {
    Name = "VpcTerraform"
  }
}
# Define the public subnets
resource "aws_subnet" "public-subnet1" {
  vpc_id = "${aws_vpc.default.id}"
  cidr_block = "${var.public_subnet1_cidr}"
  availability_zone = "us-east-1a"
  tags {
    Name = "PubSub1Terraform"
  }
}
resource "aws_subnet" "public-subnet2" {
  vpc_id = "${aws_vpc.default.id}"
  cidr_block = "${var.public_subnet2_cidr}"
  availability_zone = "us-east-1b"
  tags {
    Name = "PubSub2Terraform"
  }
}
# Define the private subnets
resource "aws_subnet" "private-subnet1" {
  vpc_id = "${aws_vpc.default.id}"
  cidr_block = "${var.private_subnet1_cidr}"
  availability_zone = "us-east-1a"
  tags {
    Name = "PriSub1Terraform"
  }
}
resource "aws_subnet" "private-subnet2" {
  vpc_id = "${aws_vpc.default.id}"
  cidr_block = "${var.private_subnet2_cidr}"
  availability_zone = "us-east-1b"
  tags {
    Name = "PriSub2Terraform"
  }
}
# Define the internet gateway
resource "aws_internet_gateway" "gw" {
  vpc_id = "${aws_vpc.default.id}"
  tags {
    Name = "IGTerraform"
  }
}
# Define the public route table
resource "aws_route_table" "public-rt" {
  vpc_id = "${aws_vpc.default.id}"
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = "${aws_internet_gateway.gw.id}"
  }
  tags {
    Name = "PubRTTerraform"
  }
}
# Assign the route table to the public Subnets
resource "aws_route_table_association" "public-rt1" {
  subnet_id = "${aws_subnet.public-subnet1.id}"
  route_table_id = "${aws_route_table.public-rt.id}"
}
resource "aws_route_table_association" "public-rt2" {
  subnet_id = "${aws_subnet.public-subnet2.id}"
  route_table_id = "${aws_route_table.public-rt.id}"
}
# Define the public route table
resource "aws_route_table" "private-rt" {
  vpc_id = "${aws_vpc.default.id}"
  tags {
    Name = "PriRTTerraform"
  }
}
# Assign the route table to the private Subnets
resource "aws_route_table_association" "private-rt1" {
  subnet_id = "${aws_subnet.private-subnet1.id}"
  route_table_id = "${aws_route_table.private-rt.id}"
}
resource "aws_route_table_association" "private-rt2" {
  subnet_id = "${aws_subnet.private-subnet2.id}"
  route_table_id = "${aws_route_table.private-rt.id}"
}
# Define the security group for an instance
resource "aws_security_group" "sgec2" {
  name = "vpc_test_web"
  description = "Allow all type of connection"

  ingress {
    from_port = 0
    to_port = 0
    protocol = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
  egress {
    from_port = 0
    to_port = 0
    protocol = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
  vpc_id="${aws_vpc.default.id}"
  tags {
    Name = "Ec2SGTerraform"
  }
}
# Define the network security group for public subnets
resource "aws_network_acl" "PubNacl" {
  vpc_id = "${aws_vpc.default.id}"
  subnet_ids = ["${aws_subnet.public-subnet1.id}","${aws_subnet.public-subnet2.id}"]

  egress {
    protocol   = "-1"
    rule_no    = 100
    action     = "allow"
    cidr_block = "0.0.0.0/0"
    from_port  = 0
    to_port    = 0
  }

  ingress {
    protocol   = "-1"
    rule_no    = 100
    action     = "allow"
    cidr_block = "0.0.0.0/0"
    from_port  = 0
    to_port    = 0
  }

  tags {
    Name = "PubNaclTerraform"
  }
}
# Define the network security group for private subnets
resource "aws_network_acl" "PriNacl" {
  vpc_id = "${aws_vpc.default.id}"
  subnet_ids = ["${aws_subnet.private-subnet1.id}","${aws_subnet.private-subnet2.id}"]
  egress {
    protocol   = "-1"
    rule_no    = 100
    action     = "allow"
    cidr_block = "0.0.0.0/0"
    from_port  = 0
    to_port    = 0
  }

  ingress {
    protocol   = "-1"
    rule_no    = 100
    action     = "allow"
    cidr_block = "0.0.0.0/0"
    from_port  = 0
    to_port    = 0
  }

  tags {
    Name = "PriNaclTerraform"
  }
}