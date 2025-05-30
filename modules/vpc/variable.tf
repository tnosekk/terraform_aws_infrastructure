variable "project_name" {
  description = "Name of the project"
  type = string
}

variable "environment" {
  description = "Environment name"
  type = string
}

variable "vpc_cidr" {
  description = "CIDR block for VPC"
  type = string
}

variable "public_subnet_cidrs" {
  description = "CIDR block for public subnets"
  type = list(string)
}

variable "private_subnet_cidrs" {
  description = "CIDR block for private subnets"
  type = list(string)
}

variable "availability_zones" {
  description = "Availability zones"
  type = list(string)
}
