variable "name" {
  description = "Name to be used on all the resources as identifier"
  type        = string
  default     = "app"
}

variable "cidr" {
  description = "The IPv4 CIDR block for the VPC"
  type        = string
  default     = "10.0.0.0/16"
}

variable "azs" {
  description = "A list of availability zones names or ids in the region"
  type        = list(string)
  default     = []
}

variable "tags" {
  description = "A map of tags to add to all resources"
  type        = map(string)
  default     = {}
}

variable "create_mysql" {
  description = "Controls if mysql database should be created"
  type        = bool
  default     = false
}

variable "create_ec2" {
  description = "Controls if ec2 instances should be created"
  type        = bool
  default     = false
}

variable "database_config" {
  description = "Database configuration"
  type        = map(string)
  default = {}
}

variable "compute_instances" {
  description = "EC2 configuration"
  type        = any
  default     = {}
}



locals {
  env_name           = var.name
  region             = "il-central-1"

  azs      = length(var.azs) > 0 ? var.azs : slice(data.aws_availability_zones.available.names, 0, 3)

  vpc_cidr = var.cidr

  tags = merge(
    {
      Terraform = "true"
      Environment = "dev"
    },
    var.tags
  )

  database_config = merge(
    {
      instance_class       = "db.t4g.large"
      allocated_storage     = 20
      max_allocated_storage = 100
      identifier = "${var.name}-mysql"
    },
    var.database_config
  )
}