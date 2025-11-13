# learning-english-infra

Infrastructure as Code (IaC) for Learning English application using Terraform and Google Cloud Platform.

## Overview

This repository manages the infrastructure for the Learning English application, including:
- GCP project configuration
- OAuth 2.0 client for Google authentication
- Firebase project with Firestore database
- Firebase security rules and anonymous authentication

## Prerequisites

- [Terraform](https://www.terraform.io/downloads.html) >= 1.0
- [Google Cloud SDK](https://cloud.google.com/sdk/docs/install)
- GCP Project with billing enabled
- Appropriate GCP permissions (Project Editor or specific IAM roles)

## Setup

### 1. Authenticate with Google Cloud

```bash
gcloud auth application-default login
```

### 2. Create GCS Bucket for Terraform State

Before initializing Terraform, create a GCS bucket to store the remote state:

```bash
# Set your project ID
export PROJECT_ID="your-gcp-project-id"

# Create the state bucket
gsutil mb -p ${PROJECT_ID} -l us-central1 gs://learning-english-terraform-state

# Enable versioning for state recovery
gsutil versioning set on gs://learning-english-terraform-state
```

### 3. Configure Variables

Copy the example variables file and customize it:

```bash
cp terraform.tfvars.example terraform.tfvars
# Edit terraform.tfvars with your project details
```

### 4. Initialize Terraform

```bash
terraform init
```

### 5. Review and Apply Changes

```bash
# Review planned changes
terraform plan

# Apply changes
terraform apply
```

## Project Structure

```
.
├── backend.tf          # Remote state configuration (GCS)
├── provider.tf         # GCP provider configuration
├── versions.tf         # Terraform and provider version constraints
├── variables.tf        # Input variable definitions
├── outputs.tf          # Output value definitions
├── oauth.tf           # OAuth client resources (placeholder)
├── firebase.tf        # Firebase project and database resources (placeholder)
└── terraform.tfvars.example  # Example variable values
```

## Remote State

This project uses Google Cloud Storage (GCS) for remote state management:
- **Bucket**: `learning-english-terraform-state`
- **Prefix**: `terraform/state`

Benefits:
- Shared state across team members
- State locking to prevent concurrent modifications
- Version history for state recovery

## Migration Plan

The following resources will be migrated to this IaC:

### Phase 1: Core Infrastructure
- [x] Terraform configuration with GCP provider
- [x] Remote state backend setup
- [ ] GCP project configuration

### Phase 2: Authentication
- [ ] OAuth 2.0 client configuration
- [ ] Google login integration

### Phase 3: Firebase
- [ ] Firebase project setup
- [ ] Firestore database configuration
- [ ] Firebase security rules
- [ ] Anonymous authentication setup

## Usage

### Common Commands

```bash
# Format Terraform files
terraform fmt

# Validate configuration
terraform validate

# Plan changes
terraform plan

# Apply changes
terraform apply

# Destroy infrastructure (use with caution!)
terraform destroy
```

### Importing Existing Resources

To import existing GCP resources into Terraform state:

```bash
# Example: Import an existing OAuth client
terraform import google_iap_client.oauth_client projects/PROJECT_ID/brands/BRAND_ID/identityAwareProxyClients/CLIENT_ID
```

## Security Notes

- `terraform.tfvars` is gitignored and should never be committed
- State files may contain sensitive data - the GCS bucket should have restricted access
- Use workspaces or separate state files for different environments
- Consider using Terraform Cloud or GCS backend encryption for additional security

## Contributing

1. Create a feature branch
2. Make changes and test with `terraform plan`
3. Submit a pull request with a clear description of changes

## License

See LICENSE file for details.