################################################################################
# RDS Module
################################################################################

module "db" {
  source = "terraform-aws-modules/rds/aws"
  version = "6.4.0"

  count = var.create_mysql ? 1 : 0

  identifier = local.database_config.identifier

  # All available versions: http://docs.aws.amazon.com/AmazonRDS/latest/UserGuide/CHAP_MySQL.html#MySQL.Concepts.VersionMgmt
  engine               = "mysql"
  engine_version       = "8.0"
  family               = "mysql8.0" # DB parameter group
  major_engine_version = "8.0"      # DB option group
  instance_class       = local.database_config.instance_class

  allocated_storage     = local.database_config.allocated_storage
  max_allocated_storage = local.database_config.max_allocated_storage

  db_name  = local.env_name
  username = local.env_name
  manage_master_user_password = true # master password will be created in secrets manager
  port     = 3306

  multi_az               = false
  db_subnet_group_name   = module.vpc.database_subnet_group
  vpc_security_group_ids = [module.security_group.security_group_id]

  maintenance_window              = "Mon:00:00-Mon:03:00"
  backup_window                   = "03:00-06:00"
  enabled_cloudwatch_logs_exports = ["general"]
  create_cloudwatch_log_group     = true

  # for dev environments - don't use for production
  skip_final_snapshot = true
  deletion_protection = false

  # performance_insights_enabled          = true
  # performance_insights_retention_period = 7
  # create_monitoring_role                = true
  # monitoring_interval                   = 60

  parameters = [
    {
      name  = "character_set_client"
      value = "utf8mb4"
    },
    {
      name  = "character_set_server"
      value = "utf8mb4"
    }
  ]

  tags = local.tags
}