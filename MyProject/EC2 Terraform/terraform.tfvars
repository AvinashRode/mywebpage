# AWS Region
region = "eu-central-1"  # Frankfurt, Germany

# VPC Configuration
vpc_name = "mywebpage-vpc"
vpc_cidr = "10.0.0.0/16"
availability_zones = ["eu-central-1a", "eu-central-1b"]
private_subnets = ["10.0.1.0/24", "10.0.2.0/24"]  # Ensure there are at least two private subnets
public_subnets = ["10.0.3.0/24", "10.0.4.0/24"]  # Ensure there are at least two public subnets in different AZs

# EC2 Instance Configuration
ami_id = "ami-0dbab8b4d0d4283d2"  # Replace with your actual AMI ID
instance_type = "t2.micro"
key_name = "test"  # Replace with your actual SSH key name

# IAM Role Configuration
iam_role_name = "mywebpage-role"
iam_instance_profile_name = "mywebpage-instance-profile"

# Security Groups
private_instance_sg_name = "mywebpage-instance-sg"
alb_sg_name = "mywebpage-alb-sg"

# Application Load Balancer Configuration
alb_name = "mywebpage-alb"
alb_listener_port = 80

# Target Group Configuration
target_group_name = "my-webpage-target-group"
target_group_port = 80
