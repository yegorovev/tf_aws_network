# VPC
output "vpс" {
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

# Default route table
output "sg" {
  value = module.default_rt
}
