output "instance_public_ip" {
  description = "Public IP address of the demonstration instance."
  value       = aws_instance.app.public_ip
}

output "vpc_id" {
  description = "ID of the provisioned VPC."
  value       = aws_vpc.this.id
}
