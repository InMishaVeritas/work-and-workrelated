# Production environment backend configuration

terraform {
  # Uncomment to configure backend for remote state storage
  # backend "s3" {
  #   bucket         = "terraform-state-bucket"
  #   key            = "prod/terraform.tfstate"
  #   region         = "us-west-2"
  #   dynamodb_table = "terraform-locks"
  #   encrypt        = true
  # }
}

# For production environments, it's strongly recommended to use remote state
# with proper access controls and state locking to prevent concurrent modifications