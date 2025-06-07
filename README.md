# AWS basic Infrastructure with Terraform

## Architecture Overview

- **VPC** - Custom VPC with public and private subnets

    ![vpc-graph](/graphs/vpc_graph.png)

- **EC2** - Web server (public subnet) and App server (private subnet)

    ![ec2-graph](/graphs/ec2_graph.png)

- **S3** - Secure bucket with versioning and basic lifecycle policies

    ![s3-graph](/graphs/s3_graph.png)

- **IAM** - Roles and polisies for secure resource access

    ![iam-graph](/graphs/iam_graph.png)


## Prerequisites

- AWS account
- Terraform >= 1.0
- AWS CLI
- EC2 Key Pair created in target region

## Quick Start

1. **Clone and setup**:

    ```bash
    git clone https://github.com/tnosekk/terraform_aws_infrastructure.git
    cd terraform_aws_inftrastructure
    cp terraform.tfvars.example terraform.tfvars
    ```

2. **Configure variables**

    Edit `terraform.tfvars` with your specific values

3. **Deploy infrastructure**

    ```bash
    terraform init
    terraform plan
    terraform apply
    ```

4. **Access you resources**

    - Web server: `http://<web_server_public_ip>`
    - SSH to web server: `ssh -i <your-key>.pem ec2-user@<web_server_public_ip>`

## Module structure

- **Input variables**
- **Output variables**
- **Resource tagging**

## Cleanup

To destroy all resources

```bash
terraform destroy
```
