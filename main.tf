# VPC
module "vpc" {
  source   = "github.com/yegorovev/tf-aws-vpc.git"
  vpc_cidr = var.vpc_cidr
  vpc_name = var.vpc_name
}
