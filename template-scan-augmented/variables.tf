# Variables for Terraform configuration

variable "project_name" {
  description = "Name of the project"
  type        = string
  default     = "terraform-project"
}

variable "environment" {
  description = "Environment (dev, staging, prod)"
  type        = string
  default     = "dev"
}

variable "region" {
  description = "AWS region"
  type        = string
  default     = "us-west-2"
}

# Example variable for S3 bucket
variable "bucket_name" {
  description = "Name of the S3 bucket"
  type        = string
  default     = "my-terraform-bucket"
}

# Example variable for VPC CIDR
variable "vpc_cidr" {
  description = "CIDR block for VPC"
  type        = string
  default     = "10.0.0.0/16"
}

# Example variable for availability zones
variable "availability_zones" {
  description = "List of availability zones"
  type        = list(string)
  default     = ["us-west-2a", "us-west-2b", "us-west-2c"]
}

# Example variable for tags
variable "additional_tags" {
  description = "Additional tags for resources"
  type        = map(string)
  default     = {}
}