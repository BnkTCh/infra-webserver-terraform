provider "aws" {
  access_key = var.AWS_ACCESS_KEY
  secret_key = var.AWS_SECRET_KEY
  region  = "us-east-1"

  default_tags {
    tags = {
      "owner"        = "bianca.torres"
      "from"         = "terraform"
    }
  }
}