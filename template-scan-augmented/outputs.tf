# Output values from Terraform configuration

# Example output for S3 bucket
# Uncomment when using the S3 bucket resource
/*
output "bucket_id" {
  description = "The ID of the S3 bucket"
  value       = aws_s3_bucket.example.id
}

output "bucket_arn" {
  description = "The ARN of the S3 bucket"
  value       = aws_s3_bucket.example.arn
}
*/

# Example output for VPC
# Uncomment when using the VPC module
/*
output "vpc_id" {
  description = "The ID of the VPC"
  value       = module.vpc.vpc_id
}

output "private_subnets" {
  description = "List of IDs of private subnets"
  value       = module.vpc.private_subnets
}

output "public_subnets" {
  description = "List of IDs of public subnets"
  value       = module.vpc.public_subnets
}
*/

# General outputs
output "project_name" {
  description = "Name of the project"
  value       = var.project_name
}

output "environment" {
  description = "Environment being deployed"
  value       = var.environment
}

output "region" {
  description = "AWS region"
  value       = var.region
}