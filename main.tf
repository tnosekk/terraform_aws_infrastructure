terraform {
	required_version = ">= 1.0"
	required_providers {
		aws = {
			source = "hashicorp/aws"
			version = "~> 5.0"
		}
	}
}

provider "aws" {
	region = var.aws_region

	default_tags {
		tags = {
			Project = var.project_name
			Environment = var.environment
			ManagedBy = "Terraform"
		}
	}
}

module "vpc" {
	source = "./modules/vpc"

	project_name = var.project_name
	environment = var.environment
	vpc_cidr = var.vpc_cidr

	public_subnet_cidrs = var.public_subnet_cidrs
	private_subnet_cidrs = var.private_subnet_cidrs
	availability_zones = var.availability_zones	
}

module "iam" {
	source = "./modules/iam"

	project_name = var.project_name
	environment = var.environment
}

module "s3" {
	source = "./modules/s3"

	project_name = var.project_name
	environment = var.environment
	bucket_name = var.s3_bucket_name
}

module "ec2" {
	source = "./modules/ec2"

	project_name = var.project_name
	environment = var.environment
	vpc_id = module.vpc.vpc_id
	public_subnet_ids = module.vpc.public_subnet_ids
	private_subnet_ids = module.vpc.private_subnet_ids
	instance_type = var.instance_type
	key_pair_name = var.key_pair_name
	iam_instance_profile = module.iam.ec2_insance_profile_name

	depends_on = [ module.vpc, module.iam ]
}