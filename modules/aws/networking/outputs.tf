output "vpc_id" {
  value = aws_vpc.vpc-xl-ago-pa.id
}

output "sn-pvt-1a-id" {
  value = aws_subnet.sn-ac-xl-ago-pvt-1a-pa.id
}

output "sn-pvt-2b-id" {
  value = aws_subnet.sn-ac-xl-ago-pvt-2b-pa.id
}

output "sn-pub-1a-id" {
  value = aws_subnet.sn-ac-xl-ago-pub-1a-pa.id
}

output "sn-pub-2b-id" {
  value = aws_subnet.sn-ac-xl-ago-pub-2b-pa.id
}

output "sg_pvt_id" {
  value = aws_security_group.sgp-ac-xl-ago-pvt-pa.id
}

output "sg_pub_id" {
  value = aws_security_group.sgp-ac-xl-ago-pub-pa.id
}

output "alb_dns_name" {
  value = aws_lb.alb-ac-xl-ago-pa.dns_name
}