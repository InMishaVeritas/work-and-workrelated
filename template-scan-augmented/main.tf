# Main Terraform configuration file

# Example resource - AWS S3 bucket
# Uncomment and modify as needed
/*
resource "aws_s3_bucket" "example" {
  bucket = var.bucket_name
  acl    = "private"

  tags = {
    Name        = "Example bucket"
    Environment = var.environment
  }
}
*/

# Example module usage from the Terraform Registry
# Uncomment and modify as needed
/*
module "vpc" {
  source = "terraform-aws-modules/vpc/aws"

  name = "my-vpc"
  cidr = "10.0.0.0/16"

  azs             = ["us-west-2a", "us-west-2b", "us-west-2c"]
  private_subnets = ["10.0.1.0/24", "10.0.2.0/24", "10.0.3.0/24"]
  public_subnets  = ["10.0.101.0/24", "10.0.102.0/24", "10.0.103.0/24"]

  enable_nat_gateway = true
  single_nat_gateway = true

  tags = {
    Environment = var.environment
    Project     = var.project_name
  }
}
*/

# Example usage of the local example module
# Uncomment and modify as needed
/*
module "example_s3_bucket" {
  source = "./modules/example"

  bucket_name = "${var.project_name}-${var.environment}-bucket"

  tags = local.common_tags
}
*/

# Local values
locals {
  common_tags = {
    Project     = var.project_name
    Environment = var.environment
    ManagedBy   = "Terraform"
  }
}
