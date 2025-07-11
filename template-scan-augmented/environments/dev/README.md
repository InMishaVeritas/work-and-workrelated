# Dev Environment

This directory contains Terraform configuration for the development environment.

## Usage

To deploy the dev environment:

1. Navigate to this directory:
   ```
   cd environments/dev
   ```

2. Initialize Terraform:
   ```
   terraform init
   ```

3. Plan the deployment:
   ```
   terraform plan
   ```

4. Apply the changes:
   ```
   terraform apply
   ```

## Configuration

The dev environment uses the following configuration:

- Project Name: terraform-project
- Environment: dev
- Region: us-west-2

## Remote State

This environment is configured to use a local state file by default. To use remote state storage:

1. Uncomment the backend configuration in `backend.tf`
2. Update the bucket name, region, and other parameters as needed
3. Run `terraform init` to initialize the backend

## Notes

- This is a development environment and may contain resources that are not suitable for production use.
- Resources in this environment may be destroyed or recreated frequently.