# Define SSH key pair for our instances
resource "aws_key_pair" "default" {
  key_name = "MLtestKP"
  public_key = "${file("${var.key_path}")}"
}

# Define webserver inside the public subnet1
resource "aws_instance" "wb" {
   ami  = "${var.ami}"
   instance_type = "t2.micro"
   key_name = "${aws_key_pair.default.id}"
   subnet_id = "${aws_subnet.public-subnet1.id}"
   vpc_security_group_ids = ["${aws_security_group.sgec2.id}"]
   associate_public_ip_address = true
   source_dest_check = false
 
  tags {
    Name = "Ec2Terraform"
  }
}