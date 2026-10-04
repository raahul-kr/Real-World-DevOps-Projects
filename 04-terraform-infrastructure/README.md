# Project 4 — Terraform Infrastructure

This project provisions the networking and security-group foundation for Project 3.
The default configuration is intentionally conservative and requires an explicit
`terraform apply` with a supplied SSH CIDR.

## Usage

```powershell
terraform init
terraform fmt -check
terraform validate
terraform plan -var="ssh_cidr=203.0.113.10/32"
```

`terraform apply` is not run by the repository workflow. Review the plan, configure
remote state with locking for a shared environment, and apply only from an authenticated
operator or a protected deployment role.

## Design

* The default VPC is isolated from the default AWS account network.
* Public subnets are used only for the small EC2 demonstration deployment.
* HTTP is open to the internet; SSH is restricted to `ssh_cidr`.
* The AMI ID is a variable so it can be selected per region.
