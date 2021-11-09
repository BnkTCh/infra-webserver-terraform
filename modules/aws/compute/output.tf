output "WS_1_Private_IP" {
  value = aws_instance.ws-1-ac-xl-ago-pa.private_ip
}

output "WS_2_Private_IP" {
  value = aws_instance.ws-2-ac-xl-ago-pa.private_ip
}

output "Bastion_IP" {
  value = aws_instance.bastion-ac-xl-ago-pa.public_ip
}

output "ec2_instance1_id" {
  value = aws_instance.ws-1-ac-xl-ago-pa.id
}

output "ec2_instance2_id" {
  value = aws_instance.ws-2-ac-xl-ago-pa.id
}