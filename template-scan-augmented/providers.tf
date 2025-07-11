# Provider configuration for Terraform

terraform {
  required_version = ">= 1.0.0"
  
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.0"
    }
    # Add other providers as needed
    # Example:
    # azurerm = {
    #   source  = "hashicorp/azurerm"
    #   version = "~> 3.0"
    # }
  }
  
  # Uncomment to configure backend for remote state storage
  # backend "s3" {
  #   bucket         = "terraform-state-bucket"
  #   key            = "terraform.tfstate"
  #   region         = "us-west-2"
  #   dynamodb_table = "terraform-locks"
  #   encrypt        = true
  # }
}

# AWS Provider configuration
provider "aws" {
  region = var.region
  
  # Uncomment to use profile from AWS credentials file
  # profile = "default"
  
  default_tags {
    tags = {
      Project     = var.project_name
      Environment = var.environment
      ManagedBy   = "Terraform"
    }
  }
}

# Example Azure Provider configuration
# Uncomment if needed
# provider "azurerm" {
#   features {}
# }