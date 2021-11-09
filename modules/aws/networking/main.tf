#Creating 1 VPC required

resource "aws_vpc" "vpc-xl-ago-pa" {
  cidr_block = "172.16.0.0/24"
  instance_tenancy = "default"
  enable_dns_hostnames = true
  tags = {
    Name = "vpc-xl-ago-pa"
  }
}

#Creating 4 subnets required (2 privates and 2 publics)

#private subnet
resource "aws_subnet" "sn-ac-xl-ago-pvt-1a-pa" {
  cidr_block = "172.16.0.0/26"
  vpc_id = aws_vpc.vpc-xl-ago-pa.id
  availability_zone = var.aval_zone1
  tags = {
    Name = "sn-ac-xl-ago-pvt-1a-pa"
  }
}

#private subnet
resource "aws_subnet" "sn-ac-xl-ago-pvt-2b-pa" {
  cidr_block = "172.16.0.64/26"
  vpc_id = aws_vpc.vpc-xl-ago-pa.id
  availability_zone = var.aval_zone2
  tags = {
    Name = "sn-ac-xl-ago-pvt-2b-pa"
  }
}

#public subnet
resource "aws_subnet" "sn-ac-xl-ago-pub-1a-pa" {
  cidr_block = "172.16.0.128/26"
  vpc_id = aws_vpc.vpc-xl-ago-pa.id
  availability_zone = var.aval_zone1
  map_public_ip_on_launch = true
  tags = {
    Name = "sn-ac-xl-ago-pub-1a-pa"
  } 
}

#public subnet
resource "aws_subnet" "sn-ac-xl-ago-pub-2b-pa" {
  cidr_block = "172.16.0.192/26"
  vpc_id = aws_vpc.vpc-xl-ago-pa.id
  availability_zone = var.aval_zone2
  map_public_ip_on_launch = true
  tags = {
    Name = "sn-ac-xl-ago-pub-2b-pa"
  }  
}

#Creating 1 Internet Gateway

resource "aws_internet_gateway" "ig-ac-xl-ago-pa" {
  vpc_id = aws_vpc.vpc-xl-ago-pa.id
  tags = {
    Name = "ig-ac-xl-ago-pa"
  }
}

#Creating Elastic IP for NAT Gateway
resource "aws_eip" "eip-ac-xl-ago-pa" {
  vpc = true
  tags = {
    Name = "eip-ac-xl-ago-pa"
  }
}

#Creating NAT Gateway
resource "aws_nat_gateway" "ng-ac-xl-ago-pa" {
  allocation_id = aws_eip.eip-ac-xl-ago-pa.id
  subnet_id = aws_subnet.sn-ac-xl-ago-pub-1a-pa.id
  depends_on = [aws_internet_gateway.ig-ac-xl-ago-pa]
  tags = {
    Name = "ng-ac-xl-ago-pa"
  }
}

# Creating 2 route tables

#private route table
resource "aws_route_table" "rt-ac-xl-ago-pvt-pa" {
  vpc_id = aws_vpc.vpc-xl-ago-pa.id
  route{
    cidr_block = "0.0.0.0/0"
    nat_gateway_id = aws_nat_gateway.ng-ac-xl-ago-pa.id
  }
  tags = {
    Name = "rt-ac-xl-ago-pvt-pa"
  }
}

#public route table
resource "aws_route_table" "rt-ac-xl-ago-pub-pa" {
  vpc_id = aws_vpc.vpc-xl-ago-pa.id
  route{
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.ig-ac-xl-ago-pa.id
  }
  tags = {
    Name = "rt-ac-xl-ago-pub-pa"
  }
}

# Associating the Public subnet to public route table
resource "aws_route_table_association" "rta-sn-pub1-i-pa" {
  route_table_id = aws_route_table.rt-ac-xl-ago-pub-pa.id
  subnet_id = aws_subnet.sn-ac-xl-ago-pub-1a-pa.id
}

# Associating the Public subnet to public route table
resource "aws_route_table_association" "rta-sn-pub2-i-pa" {
  route_table_id = aws_route_table.rt-ac-xl-ago-pub-pa.id
  subnet_id = aws_subnet.sn-ac-xl-ago-pub-2b-pa.id
}

# Associating the Private subnet to private route table
resource "aws_route_table_association" "rta-sn-pvt1-i-pa" {
  route_table_id = aws_route_table.rt-ac-xl-ago-pvt-pa.id
  subnet_id = aws_subnet.sn-ac-xl-ago-pvt-1a-pa.id
}

# Associating the Private subnet to private route table
resource "aws_route_table_association" "rta-sn-pvt2-i-pa" {
  route_table_id = aws_route_table.rt-ac-xl-ago-pvt-pa.id
  subnet_id = aws_subnet.sn-ac-xl-ago-pvt-2b-pa.id
}

############## SECURITY GROUPS ##################

# Defining the Public Subnet Security Group
resource "aws_security_group" "sgp-ac-xl-ago-pub-pa" {
  name = "sgp-ac-xl-ago-pub-pa"
  description = "Security Group for Public Subnet"
  vpc_id = aws_vpc.vpc-xl-ago-pa.id
  tags = {
    Name = "sgp-ac-xl-ago-pub-pa"
  }
  ingress {
    from_port = 22
    to_port = 22
    protocol = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  egress {
    from_port       = 0
    to_port         = 0
    protocol        = "-1"
    cidr_blocks     = ["0.0.0.0/0"]
  }
}

# Defining the Security Group for ALB
resource "aws_security_group" "sgp-ac-xl-ago-alb-pa" {
  name = "sgp-ac-xl-ago-alb-pa"
  description = "Security Group for ELB"
  vpc_id = aws_vpc.vpc-xl-ago-pa.id
  tags = {
    Name = "sgp-ac-xl-ago-alb-pa"
  }
  ingress {
    from_port = 80
    to_port = 80
    protocol = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  egress {
    from_port       = 0
    to_port         = 0
    protocol        = "-1"
    cidr_blocks     = ["0.0.0.0/0"]
  }
}

# Defining the Private Subnet Security Group
resource "aws_security_group" "sgp-ac-xl-ago-pvt-pa" {
  name = "sgp-ac-xl-ago-pvt-pa"
  description = "Security Group for Private Subnet"
  vpc_id = aws_vpc.vpc-xl-ago-pa.id
  tags = {
    Name = "sgp-ac-xl-ago-pvt-pa"
  }
  ingress {
    from_port = 22
    to_port = 22
    protocol = "tcp"
    security_groups = [aws_security_group.sgp-ac-xl-ago-pub-pa.id]
  }
  ingress {
    from_port = 80
    to_port = 80
    protocol = "tcp"
    security_groups = [aws_security_group.sgp-ac-xl-ago-alb-pa.id]
  }
  egress {
    from_port       = 0
    to_port         = 0
    protocol        = "-1"
    cidr_blocks     = ["0.0.0.0/0"]
  }
}

#Creating Application Load Balancer

resource "aws_lb" "alb-ac-xl-ago-pa" {
  name               = "alb-ac-xl-ago-pa"
  internal           = false
  load_balancer_type = "application"
  security_groups    = [aws_security_group.sgp-ac-xl-ago-alb-pa.id]
  subnets            = [aws_subnet.sn-ac-xl-ago-pub-1a-pa.id, aws_subnet.sn-ac-xl-ago-pub-2b-pa.id]
  tags = {
    Name = "alb-ac-xl-ago-pa"
  }
}

#Creating target groups to ALB
resource "aws_lb_target_group" "tg-alb-ac-xl-ago-pa" {
  name     = "tg-alb-ac-xl-ago-pa"
  port     = 80
  protocol = "HTTP"
  vpc_id   = aws_vpc.vpc-xl-ago-pa.id
  tags = {
    Name = "tg-alb-ac-xl-ago-pa"
  }
}

#Attaching Target Group to EC2 Instances
resource "aws_lb_target_group_attachment" "tgatch-1-ac-xl-ago-pa" {
  target_group_arn = aws_lb_target_group.tg-alb-ac-xl-ago-pa.arn
  target_id        = var.ec2_instance1
  port             = 80
}
resource "aws_lb_target_group_attachment" "tgatch-2-ac-xl-ago-pa" {
  target_group_arn = aws_lb_target_group.tg-alb-ac-xl-ago-pa.arn
  target_id        = var.ec2_instance2
  port             = 80
}

### Listener Forward to ALB

resource "aws_lb_listener" "lt-ac-xl-ago-pa" {
  load_balancer_arn = aws_lb.alb-ac-xl-ago-pa.arn
  port              = "80"
  protocol          = "HTTP"

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.tg-alb-ac-xl-ago-pa.arn
  }
}


