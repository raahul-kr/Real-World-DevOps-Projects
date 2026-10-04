variable "aws_region" {
  description = "AWS region for the demonstration infrastructure."
  type        = string
  default     = "us-east-1"
}

variable "project_name" {
  description = "Name prefix for resources."
  type        = string
  default     = "devops-demo"
}

variable "ssh_cidr" {
  description = "CIDR range allowed to connect to SSH."
  type        = string

  validation {
    condition     = can(cidrhost(var.ssh_cidr, 0))
    error_message = "ssh_cidr must be a valid CIDR block."
  }
}

variable "instance_type" {
  description = "EC2 instance type for the demonstration deployment."
  type        = string
  default     = "t3.micro"
}

variable "ami_id" {
  description = "Ubuntu AMI ID for the selected region."
  type        = string
}
