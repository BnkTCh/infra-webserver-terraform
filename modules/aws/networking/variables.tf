variable "aval_zone1" {
  type = string
  description = "Availability Zone for a subnet"
  default = "us-east-1a"
}

variable "aval_zone2" {
  type = string
  description = "Availability Zone for a subnet"
  default = "us-east-1b"
}

variable "ec2_instance1" {
  type = any
}

variable "ec2_instance2" {
  type = any
}