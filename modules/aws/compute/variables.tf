variable "sn_pvt_1a" {
  type = any
}
variable "sn_pvt_2b" {
  type = any
}

variable "sn_pub_1a" {
  type = any
}

variable "sn_pub_2b" {
  type = any
}

variable "sg_pvt" {
  type = any
}

variable "sg_pub" {
  type = any
}

variable "key_name" {
  description = "Key name for SSH into EC2"
  default = "ac-xl-ag"
}