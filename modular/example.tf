# module "regular" {
#   source = "./modules/app"

# }

# module "one_az" {
#   source = "./modules/app"
  
#   azs = ["il-central-1c"]
#   cidr = "10.1.0.0/16"
# }


# module "one_az_with_db" {
#   source = "./modules/app"

#   azs = ["il-central-1c"]
#   create_mysql = true
#   cidr = "10.2.0.0/16"
# }

# module "configure_db" {
#   source = "./modules/app"
  
#   cidr = "10.3.0.0/16"
#   azs = ["il-central-1c"]
#   create_mysql = true
#   database_config = {
#     identifier = "mydb"
#     instance_class       = "db.t4g.2xlarge"
#     allocated_storage     = 500
#     max_allocated_storage = 2000    
#   }
# }

# module "one_az_with_apps" {
#   source = "./modules/app"
  
#   azs = ["il-central-1c"]
#   cidr = "10.4.0.0/16"

#   create_ec2 = true
#   compute_instances = {
#     app1 = {
#       instance_type = "m7i.large"
#       tags = {
#         special = "yes"
#       }
#     },
#     app2 = {
#       tags = {
#         special = "no"
#       }
#     },
#   }
# }

# module "multi_az_apps" {
#   source = "./modules/app"
  
#   cidr = "10.5.0.0/16"

#   create_ec2 = true
#   compute_instances = {
#     app1 = {
#       az_number = 0
#     },
#     app2 = {
#       az_number = 2
#     },
#   }
# }

module "complete" {
  source = "./modules/app"
  
  cidr = "10.6.0.0/16"
  azs = ["il-central-1a","il-central-1b"]


  create_ec2 = true
  compute_instances = {
    app1 = {
      az_number = 0
      instance_type = "t3.micro"
      tags = {
        special = "yes"
      }      
    },
    app2 = {
      az_number = 1
    },
  }

  create_mysql = true
  database_config = {
    identifier = "mydb"
    instance_class       = "db.r5.2xlarge"
    allocated_storage     = 500
    max_allocated_storage = 2000    
  }  
}
