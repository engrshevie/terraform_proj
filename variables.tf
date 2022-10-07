variable "vpc_cidr" {
  default = "10.0.0.0/16"
}

variable "vpc_tag" {
  default = "vpc_net"
}

variable "region" {
  default     = "us-east-1"
  description = "AWS region"
}

variable "db_password" {
  description = "RDS root user password"
  sensitive   = true
}
