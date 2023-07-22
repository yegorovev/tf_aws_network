# VPC
module "vpc" {
  source = "git@github.com:yegorovev/tf_aws_vpc.git?ref=v1.0.0"

  vpc_cidr             = var.vpc_cidr
  vpc_name             = var.vpc_name
  enable_dns_hostnames = var.enable_dns_hostnames
}

# Subnets
module "subnets" {
  source = "git@github.com:yegorovev/tf_aws_subnets.git?ref=v1.0.0"
  count  = length(var.subnets_list)

  vpc_id       = module.vpc.vpc.id
  subnet_cidr  = var.subnets_list[count.index].subnet_cidr
  subnet_name  = var.subnets_list[count.index].subnet_name
  zone         = var.subnets_list[count.index].zone
  is_public_ip = var.subnets_list[count.index].is_public_ip
}


# Internet gateway
module "internet_gateway" {
  source = "git@github.com:yegorovev/tf_aws_igw.git?ref=v1.0.0"

  vpc_id   = module.vpc.vpc.id
  igw_name = var.igw_name
}

# Security groups
module "security_groups" {
  count  = length(var.application_sg)
  source = "git@github.com:yegorovev/tf_aws_sg.git?ref=v1.0.0"

  sg_name        = var.application_sg[count.index].sg_name
  sg_description = var.application_sg[count.index].sg_description
  vpc_id         = module.vpc.vpc.id
  rules          = var.application_sg[count.index].rules
}


# Route tables for subnets
module "route_tables" {
  source = "git@github.com:yegorovev/tf_aws_route_table.git?ref=v1.0.0"

  vpc_id      = module.vpc.vpc.id
  route_tables        = var.rt

  depends_on = [
    module.subnets
  ]
}

# Route tables associations
module "route_table_associations" {
  source = "git@github.com:yegorovev/tf_aws_rt_association.git?ref=v1.0.0"
  count  = length(var.rt_associations)

  vpc_id      = module.vpc.vpc.id
  rt_name        = var.rt_associations[count.index].rt_name
  subnet_zone = var.rt_associations[count.index].subnet_zone
  subnet_name = var.rt_associations[count.index].subnet_name
  subnet_id   = var.rt_associations[count.index].subnet_id
  gateway_id  = var.rt_associations[count.index].gateway_id

  depends_on = [
    module.route_tables
  ]
}

# Routes
module "routes" {
  source = "git@github.com:yegorovev/tf_aws_route.git?ref=v1.0.0"
  count  = length(var.routes)

  vpc_id      = module.vpc.vpc.id
  rt_name        = var.routes[count.index].rt_name
  igw_name = var.routes[count.index].igw_name
  destination_cidr_block = var.routes[count.index].destination_cidr_block
  network_interface_id   = var.routes[count.index].network_interface_id

  depends_on = [
    module.route_tables,
    module.internet_gateway
  ]
}
