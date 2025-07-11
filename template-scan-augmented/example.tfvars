# Example variable values for Terraform configuration
# Copy this file to terraform.tfvars and modify the values according to your needs

project_name = "my-terraform-project"
environment  = "dev"
region       = "us-west-2"

# Example values for S3 bucket
bucket_name = "my-example-bucket"

# Example values for VPC
vpc_cidr = "10.0.0.0/16"
availability_zones = [
  "us-west-2a",
  "us-west-2b",
  "us-west-2c"
]

# Additional tags
additional_tags = {
  Owner       = "Your Name"
  CostCenter  = "Your Cost Center"
  Application = "Your Application"
}