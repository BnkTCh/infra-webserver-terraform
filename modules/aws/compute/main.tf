#Creating Private EC2 Instances

#Web Server 1
resource "aws_instance" "ws-1-ac-xl-ago-pa" {
  ami= data.aws_ami.amazon-linux-2.id
  subnet_id = data.aws_subnet.dsn_pvt_1a.id
  instance_type = "t2.micro"
  key_name = var.key_name
  user_data = file("../../modules/aws/compute/createApacheUserData.sh")
  vpc_security_group_ids = [data.aws_security_group.dsg_pvt.id]
  tags = {
    Name = "ws-1-ac-xl-ago-pa"
  }
}

#Web Server 2
resource "aws_instance" "ws-2-ac-xl-ago-pa" {
  ami= data.aws_ami.amazon-linux-2.id
  subnet_id = data.aws_subnet.dsn_pvt_2b.id
  instance_type = "t2.micro"
  key_name = var.key_name
  user_data = file("../../modules/aws/compute/createApacheUserData.sh")
  vpc_security_group_ids = [data.aws_security_group.dsg_pvt.id]
  tags = {
    Name = "ws-2-ac-xl-ago-pa"
  }
}

#Creating Bastion host EC2 Instance

resource "aws_instance" "bastion-ac-xl-ago-pa" {
  ami= data.aws_ami.amazon-linux-2.id
  subnet_id = data.aws_subnet.dsn_pub_2b.id
  instance_type = "t2.micro"
  key_name = var.key_name
  vpc_security_group_ids = [data.aws_security_group.dsg_pub.id]
  tags = {
    Name = "bastion-ac-xl-ago-pa"
  }
  provisioner "file" {
    source = "../../modules/aws/compute/${var.key_name}.pem"
    destination = "/home/ec2-user/${var.key_name}.pem"

    connection {
      type = "ssh"
      user = "ec2-user"
      private_key = file("../../modules/aws/compute/${var.key_name}.pem")
      host = self.public_ip
    }
  }
  provisioner "remote-exec" {
    inline = ["chmod 400 ~/${var.key_name}.pem"]
    connection {
      type = "ssh"
      user = "ec2-user"
      private_key = file("../../modules/aws/compute/${var.key_name}.pem")
      host = self.public_ip
    }
  }
}