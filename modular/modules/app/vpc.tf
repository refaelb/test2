################################################################################
# VPC Module
################################################################################
module "vpc" {
  source = "terraform-aws-modules/vpc/aws"

  name = local.env_name
  cidr = local.vpc_cidr

  azs              = local.azs
#  public_subnets   = [for k, v in local.azs : cidrsubnet(local.vpc_cidr, 8, k + 1)]
  private_subnets  = [for k, v in local.azs : cidrsubnet(local.vpc_cidr, 8, k + 11)]
  database_subnets = [for k, v in local.azs : cidrsubnet(local.vpc_cidr, 8, k + 21)]

#  create_database_subnet_group = true

#  enable_nat_gateway = true
  one_nat_gateway_per_az = false

  # for dev environments - don't use for production
#  single_nat_gateway = true

  enable_dns_hostnames = true
  enable_dns_support   = true

  tags = local.tags 

#  public_subnet_tags = {
#    "subnet/${local.env_name}" = "public"
#  }

  private_subnet_tags = {
    "subnet/${local.env_name}" = "private"
  }

  database_subnet_tags = {
    "subnet/${local.env_name}" = "database"
  }
  
}


################################################################################
# Security Group Module
################################################################################
module "security_group" {
  source  = "terraform-aws-modules/security-group/aws"
  version = "~> 5.0"

  name        = local.env_name
  description = "Complete MySQL example security group"
  vpc_id      = module.vpc.vpc_id

  # ingress
  ingress_with_cidr_blocks = [
    {
      from_port   = 3306
      to_port     = 3306
      protocol    = "tcp"
      description = "MySQL access from within VPC"
      cidr_blocks = module.vpc.vpc_cidr_block
    },
  ]

  tags = local.tags
}
