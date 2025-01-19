# Terraform Project

This repository contains Terraform configurations to manage infrastructure across multiple environments (dev, staging, and prod) with reusable modules.

## Structure
```
├── environments
│   ├── dev
│   ├── prod
│   └── staging
└── modules
    ├── ArgoCD
    ├── ECR
    ├── EKS
    ├── database
    ├── karpenter
    └── networking
```

## Environments
Each environment (`dev`, `staging`, `prod`) has:
- `backend.tf`: Remote state configuration
- `main.tf`: Resources definitions
- `provider.tf`: Provider setup
- `terraform.tfvars`: Environment-specific variables
- `variables.tf`: Input variable definitions

## Modules
Reusable modules include:
- **ArgoCD**: Configures ArgoCD, ingress, Prometheus, and ACM
- **ECR**: Manages Elastic Container Registry
- **EKS**: Sets up EKS with OIDC and Karpenter
- **database**: Configures databases, secrets, and security groups
- **karpenter**: Manages Kubernetes autoscaling
- **networking**: Creates networking resources

## Connected Repositories
This project connects to the following repositories:
- [Movie-app](https://github.com/OmerSade1/Movie-app)
- [argocd-gitops](https://github.com/OmerSade1/argocd-gitops)

## Usage
1. Clone the repository:
   ```bash
   git clone <repository-url>
   ```
2. Navigate to the desired environment:
   ```bash
   cd environments/dev
   ```
3. Initialize Terraform:
   ```bash
   terraform init
   ```
4. Plan and apply changes:
   ```bash
   terraform plan
   terraform apply
   ```

## Prerequisites
- Terraform >= 1.0.0
- AWS CLI configured with credentials
- Permissions for AWS resources

## License
This project is licensed under the MIT License.

