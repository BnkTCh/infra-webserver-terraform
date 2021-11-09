data "aws_ami" "amazon-linux-2" {
  most_recent = true
  owners      = ["amazon"]
  filter {
    name   = "name"
    values = ["amzn2-ami-hvm*"]
  }
}

data "aws_subnet" "dsn_pvt_1a" {
  id = var.sn_pvt_1a
}

data "aws_subnet" "dsn_pvt_2b" {
  id = var.sn_pvt_2b
}

data "aws_subnet" "dsn_pub_2b" {
  id = var.sn_pub_2b
}

data "aws_security_group" "dsg_pvt" {
  id = var.sg_pvt
}

data "aws_security_group" "dsg_pub" {
  id = var.sg_pub
}




