# terraform.tfvars
region                   = "eu-central-1"  # Frankfurt, Germany
vpc_name                 = "my-webpage-vpc"
vpc_cidr                 = "10.0.0.0/16"
availability_zones       = ["eu-central-1a", "eu-central-1b"]
private_subnets          = ["10.0.1.0/24"]
public_subnets           = ["10.0.3.0/24"]
cluster_name             = "my-eks-cluster"
worker_instance_type     = "t2.micro"
worker_asg_max_size      = 1
worker_asg_min_size      = 1
worker_asg_desired_capacity = 1
key_name                 = "my-ssh-key"  # Replace with your actual SSH key name
