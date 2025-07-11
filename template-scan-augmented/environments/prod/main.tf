# Production environment configuration

module "prod" {
  source = "../.."  # Root module

  # Override variables for production environment
  project_name = "terraform-project"
  environment  = "prod"
  region       = "us-west-2"
  
  # Example S3 bucket configuration
  bucket_name = "terraform-project-prod-bucket"
  
  # Additional tags specific to production environment
  additional_tags = {
    Owner       = "DevOps Team"
    CostCenter  = "IT-123"
    Application = "Example App - Production"
  }
}

# You can add environment-specific resources here
# For production, you might want to add additional security measures
# or high-availability configurations