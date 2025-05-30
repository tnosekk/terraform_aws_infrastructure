variable "aws_region" {
    description = "AWS region for resource"
    type = string
    default = "us-west-2"
}

variable "project_name" {
    description = "Name of the project"
    type = string
    default = "devops-portfolio"
}

variable "environment" {
    description = "Environment name"
    type = string
    default = "dev"
}

variable "vpc_cidr" {
    description = "CIDR block for VPC"
    type = string
    default = "10.0.0.0/16"
}

variable "public_subnet_cidrs" {
    description = "CIDR block for public subnets"
    type = list(string)
    default = [ "10.0.1.0/24", "10.0.2.0/24" ]
}

variable "private_subnet_cidrs" {
    description = "CIDR block for private subnets"
    type = list(string)
    default = [ "10.0.10.0/24", "10.0.20.0/24" ]
}

variable "availability_zones" {
    description = "Availability zones"
    type = list(string)
    default = [ "us-west-2a", "us-west-2b" ]
}

variable "instance_type" {
  description = "EC2 instance type"
  type = string
  default = "t3.micro"
}

variable "key_pair_name" {
  description = "AWS Key Pair name for EC2 instances"
  type = string
}

variable "s3_bucket_name" {
    description = "Name for S3 bucket"
    type = string
}