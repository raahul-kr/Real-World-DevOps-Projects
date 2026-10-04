# Project 8 — Complete DevSecOps Pipeline

The workflow in `.github/workflows/devsecops.yml` combines the earlier projects into
one pull-request quality gate:

* Python tests
* Trivy filesystem and image scanning
* Gitleaks secret scanning
* Terraform format and validation checks
* Kubernetes manifest validation with kubeconform

The workflow uses immutable action major versions and never grants cloud credentials.
Deployment should be a separate protected environment after these checks pass.
