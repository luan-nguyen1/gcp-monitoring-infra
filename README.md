# GCP Infrastructure

Infrastructure as Code for Google Cloud Platform using Terraform.

## Features

- Modular design with reusable components
- Network module for VPC and subnet creation
- Compute module for VM instance provisioning
- Environment-specific configurations
- Automated deployment of monitoring service

## Prerequisites

- Terraform >= 0.14
- Google Cloud SDK
- GCP Project with billing enabled
- Service account with appropriate permissions

## Usage

### Development Environment

1. Navigate to the development environment directory:
cd environments/dev


2. Create a `terraform.tfvars` file based on the example:
cp terraform.tfvars.example terraform.tfvars


3. Edit `terraform.tfvars` with your specific values.

4. Initialize Terraform:
terraform init


5. Plan the deployment:
terraform plan


6. Apply the configuration:
terraform apply


### Production Environment

Similar steps apply for the production environment:

cd environments/prod
cp terraform.tfvars.example terraform.tfvars

Edit terraform.tfvars
terraform init
terraform plan
terraform apply


## Modules

### Network Module

Creates a VPC network with subnets and firewall rules.

### Compute Module

Provisions VM instances with customizable configurations.

## Cleanup

To destroy the infrastructure:

terraform destroy

