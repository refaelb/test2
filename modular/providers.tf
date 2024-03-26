
# provider "aws" {
#   region  = "us-east-1"
#   profile = "infinit"

#   # assume_role {
#   #   role_arn = "local.terraform_arn"
#   # }
# }

provider "aws" {
  region  = "us-east-1"
  profile = "infinit"
}
provider "aws" {
  profile = "infinit"
  region = "us-east-1"
  alias = "us-east-1"
}