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

variable "subnets_list" {
  description = "List of VPC subnets"
  type = list(object({
    subnet_cidr  = string
    subnet_name  = string
    zone         = string
    is_public_ip = bool
  }))
  default = []
}

variable "igw_name" {
  description = "IGW tag name"
  type        = string
  nullable    = false
}

variable "application_sg" {
  description = "Custom security groups for application. cidr_blocks must be separated by a comma"
  type = list(object({
    sg_name        = string
    sg_description = string
    rules          = list(map(string))
  }))
  default = []
}

variable "enable_dns_hostnames" {
  description = "A boolean flag to enable/disable DNS hostnames in the VPC"
  type        = bool
  default     = false
  nullable    = false
}

variable "rt" {
  description = "List of route tables"
  type = list(map(string))
  default = []
}

variable "rt_associations" {
  description = "List of route table associations"
  type = list(map(string))
  default = []
}

variable "routes" {
  description = "List of routs"
  type = list(map(string))
  default = []
}
