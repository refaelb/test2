module "ec2_instance" {
  source  = "terraform-aws-modules/ec2-instance/aws"
  version = "5.6.0"

  for_each = { for k, v in var.compute_instances : k => v if var.create_ec2 }

  name                   = try(each.value.name, each.key)
  instance_type          = try(each.value.instance_type, "t2.micro")
  key_name               = try(each.value.key_name, "")
  
  vpc_security_group_ids = [module.security_group.security_group_id]
  subnet_id              = try(module.vpc.private_subnets[each.value.az_number], module.vpc.private_subnets[0])

  tags = merge(
    local.tags,
    try(each.value.tags, {})
  )
}