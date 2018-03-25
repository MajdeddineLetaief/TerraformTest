variable "aws_region" {
  description = "Region for the VPC"
  default = "us-east-1"
}

variable "vpc_cidr" {
  description = "CIDR for the VPC"
  default = "10.0.0.0/16"
}

variable "public_subnet1_cidr" {
  description = "CIDR for the first public subnet"
  default = "10.0.1.0/24"
}

variable "public_subnet2_cidr" {
  description = "CIDR for the second public subnet"
  default = "10.0.2.0/24"
}

variable "private_subnet1_cidr" {
  description = "CIDR for the first private subnet"
  default = "10.0.3.0/24"
}

variable "private_subnet2_cidr" {
  description = "CIDR for the second private subnet"
  default = "10.0.4.0/24"
}

variable "ami" {
  description = "Amazon Linux AMI"
  default = "ami-66506c1c"
}

variable "key_path" {
  description = "SSH Public Key path"
  default = "/Users/projectx/Downloads/MLtestPubK"
}