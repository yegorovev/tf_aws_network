# VPC
module "vpc" {
  source = "github.com/yegorovev/tf-aws-vpc.git"

  vpc_cidr             = var.vpc_cidr
  vpc_name             = var.vpc_name
  enable_dns_hostnames = var.enable_dns_hostnames
}

# Subnets
module "subnets" {
  source = "github.com/yegorovev/tf-aws-subnets.git"
  count  = length(var.subnets_list)

  vpc_id       = module.vpc.vpc.id
  subnet_cidr  = var.subnets_list[count.index].subnet_cidr
  subnet_name  = var.subnets_list[count.index].subnet_name
  zone         = var.subnets_list[count.index].zone
  is_public_ip = var.subnets_list[count.index].is_public_ip
}


# Internet gateway
module "igw" {
  source = "github.com/yegorovev/tf-aws-igw.git"

  vpc_id   = module.vpc.vpc.id
  igw_name = var.igw_name
}

# Security groups
module "sg" {
  count  = length(var.application_sg)
  source = "github.com/yegorovev/tf-aws-sg.git"

  sg_name        = var.application_sg[count.index].sg_name
  sg_description = var.application_sg[count.index].sg_description
  vpc_id         = module.vpc.vpc.id
  rules          = var.application_sg[count.index].rules
}
