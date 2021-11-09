provider "aws" {
  region  = "us-east-1"
  profile = "parrieta"

  default_tags {
    tags = {
      env            = "ac-xl-ago",
      "cost:env"     = "academy",
      "cost:project" = "ac-xl-ago"
      "owner"        = "pedro.arrieta"
      "from"         = "terraform"
    }
  }
}