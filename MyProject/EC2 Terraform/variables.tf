# AWS Region
variable "region" {
  description = "AWS region"
  type        = string
}

# VPC Configuration
variable "vpc_name" {
  description = "Name of the VPC"
  type        = string
}

variable "vpc_cidr" {
  description = "CIDR block for the VPC"
  type        = string
}

variable "availability_zones" {
  description = "List of availability zones"
  type        = list(string)
}

variable "private_subnets" {
  description = "List of CIDR blocks for private subnets"
  type        = list(string)
}

variable "public_subnets" {
  description = "List of CIDR blocks for public subnets"
  type        = list(string)
}

# EC2 Instance Configuration
variable "ami_id" {
  description = "AMI ID for the EC2 instance"
  type        = string
}

variable "instance_type" {
  description = "Instance type for the EC2 instance"
  type        = string
}

# SSH Key Pair
variable "key_name" {
  description = "Name of the SSH key pair to access instances"
  type        = string
}

# IAM Role Configuration
variable "iam_role_name" {
  description = "Name of the IAM role"
  type        = string
}

variable "iam_instance_profile_name" {
  description = "Name of the IAM instance profile"
  type        = string
}

# Security Groups
variable "private_instance_sg_name" {
  description = "Name of the security group for the private EC2 instance"
  type        = string
}

variable "alb_sg_name" {
  description = "Name of the security group for the Application Load Balancer"
  type        = string
}

# Application Load Balancer Configuration
variable "alb_name" {
  description = "Name of the Application Load Balancer"
  type        = string
}

variable "alb_listener_port" {
  description = "Port for the Application Load Balancer listener"
  type        = number
  default     = 80
}

# Target Group Configuration
variable "target_group_name" {
  description = "Name of the target group for the Application Load Balancer"
  type        = string
}

variable "target_group_port" {
  description = "Port for the target group"
  type        = number
  default     = 80
}
