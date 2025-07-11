# Dev environment backend configuration

terraform {
  # Uncomment to configure backend for remote state storage
  # backend "s3" {
  #   bucket         = "terraform-state-bucket"
  #   key            = "dev/terraform.tfstate"
  #   region         = "us-west-2"
  #   dynamodb_table = "terraform-locks"
  #   encrypt        = true
  # }
}