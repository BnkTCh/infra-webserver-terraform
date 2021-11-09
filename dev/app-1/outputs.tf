output "For_connecting_to_web_page_use" {
  description = "ALB DNS name for connecting to web page"
  value = "${module.networking.alb_dns_name}"
}

output "Public_connection_to_Bastion_host" {
  description = "Copy/Paste/Enter - You are into Bastion Host"
  value = "ssh -i ${var.key_name}.pem ec2-user@${module.compute.Bastion_IP}"
}

output "Private_connection_to_Web_Server_1" {
  description = "Copy/Paste/Enter - You are into Web Server 1"
  value = "ssh -i ${var.key_name}.pem ec2-user@${module.compute.WS_1_Private_IP}"
}

output "Private_connection_to_Web_Server_2" {
  description = "Copy/Paste/Enter - You are into Web Server 2"
  value = "ssh -i ${var.key_name}.pem ec2-user@${module.compute.WS_2_Private_IP}"
}