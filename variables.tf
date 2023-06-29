variable "vpc_cidr" {
  description = "AWS VPC CIDR block"
  type        = string
  nullable    = false
}

variable "vpc_name" {
  description = "AWS VPC tag name"
  type        = string
  nullable    = false
}
