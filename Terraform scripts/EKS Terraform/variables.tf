# variables.tf

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

# EKS Cluster Configuration
variable "cluster_name" {
  description = "Name of the EKS cluster"
  type        = string
}

variable "worker_instance_type" {
  description = "Instance type for the worker nodes"
  type        = string
}

variable "worker_asg_max_size" {
  description = "Maximum size of the EKS worker nodes"
  type        = number
}

variable "worker_asg_min_size" {
  description = "Minimum size of the EKS worker nodes"
  type        = number
}

variable "worker_asg_desired_capacity" {
  description = "Desired capacity of the EKS worker nodes"
  type        = number
}

# SSH Key Pair
variable "key_name" {
  description = "Name of the SSH key pair to access instances"
  type        = string
}
