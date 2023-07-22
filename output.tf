# VPC
output "vpс" {
  value = module.vpc
}

# Subnets
output "subnets" {
  value = module.subnets
}

# Internet gateway
output "internet_gateway" {
  value = module.internet_gateway
}

# Security groups
output "security_groups" {
  value = module.security_groups
}

# Route tables
output "route_tables" {
  value = module.route_tables
}

# Route tables associations
output "route_table_associations" {
  value = module.route_table_associations
}

# Routes
output "routes" {
  value = module.routes
}
