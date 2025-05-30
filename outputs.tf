output "vpc_id" {
  description = "ID of the VPC"
  value = module.vpc.vpc_id
}

output "public_subnet_ids" {
  description = "IDs of the public subnets"
  value = module.vpc.public_subnet_ids
}

output "private_subnet_ids" {
    description = "IDs of the private subnets"
    value = module.vpc.private_subnet_ids
}

output "web_server_public_ip" {
  description = "Public IP of web server"
  value = module.ec2.web_server_public_ip
}

output "app_server_private_ip" {
  description = "Private IP of app server"
  value = module.ec2.app_server_private_ip
}

output "s3_bucket_name" {
  description = "Name of the S3 bucket"
  value = module.s3.bucket_name
}

output "s3_bucket_arn" {
  description = "ARN of the S3 bucket"
  value = module.s3.bucket_arn
}