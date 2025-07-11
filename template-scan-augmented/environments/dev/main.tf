# Dev environment configuration

module "dev" {
  source = "../.."  # Root module

  # Override variables for dev environment
  project_name = "terraform-project"
  environment  = "dev"
  region       = "us-west-2"
  
  # Example S3 bucket configuration
  bucket_name = "terraform-project-dev-bucket"
  
  # Additional tags specific to dev environment
  additional_tags = {
    Owner       = "DevOps Team"
    CostCenter  = "IT-123"
    Application = "Example App - Dev"
  }
}

# You can add environment-specific resources here