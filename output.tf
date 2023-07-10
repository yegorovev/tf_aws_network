# VPC
output "vps" {
  value = module.vpc
}

# Subnets
output "subnets" {
  value = module.subnets
}

# Internet gateway
output "igw" {
  value = module.igw
}

# Security groups
output "sg" {
  value = module.sg
}