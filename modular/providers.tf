
provider "aws" {
  region  = "il-central-1"
}







provider "aws" {
  assume_role {
    role_arn = "arn:aws:iam::975050210799:role/terraform-full"
    session_name = "TerraformSession"
  }
  region  = "il-central-1"
  sts_region = "il-central-1"
  alias = "il-central-1"
}

