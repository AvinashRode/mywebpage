provider "aws" {
  region = var.region
}

# VPC Configuration
resource "aws_vpc" "main" {
  cidr_block           = var.vpc_cidr
  enable_dns_support   = true
  enable_dns_hostnames = true
  tags = {
    Name = var.vpc_name
  }
}

# Public Subnets
resource "aws_subnet" "public" {
  count = length(var.public_subnets)
  vpc_id = aws_vpc.main.id
  cidr_block = element(var.public_subnets, count.index)
  availability_zone = element(var.availability_zones, count.index)
  map_public_ip_on_launch = true
  tags = {
    Name = "public-subnet-${count.index}"
  }
}

# Private Subnets
resource "aws_subnet" "private" {
  count = length(var.private_subnets)
  vpc_id = aws_vpc.main.id
  cidr_block = element(var.private_subnets, count.index)
  availability_zone = element(var.availability_zones, count.index)
  tags = {
    Name = "private-subnet-${count.index}"
  }
}

# Internet Gateway
resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.main.id
  tags = {
    Name = "main-igw"
  }
}

# Elastic IP for NAT Gateway
resource "aws_eip" "nat" {
  count = length(aws_subnet.public.*.id) > 0 ? 1 : 0
  domain = "vpc"
}

# NAT Gateway
resource "aws_nat_gateway" "nat" {
  count = length(aws_subnet.public.*.id) > 0 ? 1 : 0
  allocation_id = length(aws_eip.nat) > 0 ? aws_eip.nat[0].id : null
  subnet_id     = length(aws_subnet.public) > 0 ? aws_subnet.public[0].id : null
  tags = {
    Name = "main-nat"
  }
}

# Public Route Table
resource "aws_route_table" "public" {
  vpc_id = aws_vpc.main.id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.igw.id
  }
  tags = {
    Name = "public-route-table"
  }
}

# Public Route Table Association
resource "aws_route_table_association" "public" {
  count = length(aws_subnet.public.*.id)
  subnet_id      = element(aws_subnet.public.*.id, count.index)
  route_table_id = aws_route_table.public.id
}

# Private Route Table
resource "aws_route_table" "private" {
  vpc_id = aws_vpc.main.id
  route {
    cidr_block = "0.0.0.0/0"
    nat_gateway_id = length(aws_nat_gateway.nat) > 0 ? aws_nat_gateway.nat[0].id : null
  }
  tags = {
    Name = "private-route-table"
  }
}

# Private Route Table Association
resource "aws_route_table_association" "private" {
  count = length(aws_subnet.private.*.id)
  subnet_id      = element(aws_subnet.private.*.id, count.index)
  route_table_id = aws_route_table.private.id
}

# IAM Role for EC2 Instance
resource "aws_iam_role" "example" {
  name = "mywebpage-role"
  assume_role_policy = jsonencode({
    Version = "2012-10-17",
    Statement = [
      {
        Action = "sts:AssumeRole",
        Effect = "Allow",
        Principal = {
          Service = "ec2.amazonaws.com"
        },
      },
    ],
  })
}

# IAM Role Policy Attachment
resource "aws_iam_role_policy_attachment" "example-AmazonEC2ContainerRegistryReadOnly" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEC2ContainerRegistryReadOnly"
  role     = aws_iam_role.example.name
}

# IAM Instance Profile
resource "aws_iam_instance_profile" "example" {
  name = "mywebpage-instance-profile"
  role = aws_iam_role.example.name
}

# EC2 Instance in Private Subnet
resource "aws_instance" "example" {
  ami                  = var.ami_id
  instance_type        = var.instance_type
  subnet_id            = aws_subnet.private[0].id
  iam_instance_profile = aws_iam_instance_profile.example.name
  security_groups      = [aws_security_group.private_instance_sg.id]
  key_name             = var.key_name
  tags = {
    Name = "mywebpage-instance"
  }
}

# Security Group for Private EC2 Instance
resource "aws_security_group" "private_instance_sg" {
  vpc_id = aws_vpc.main.id
  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["10.0.0.0/16"]
  }
  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["10.0.0.0/16"]
  }
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
  tags = {
    Name = "mywebpage-private-instance-sg"
  }
}

# Application Load Balancer
resource "aws_lb" "example" {
  name               = var.alb_name
  internal           = false
  load_balancer_type = "application"
  security_groups    = [aws_security_group.alb_sg.id]
  subnets            = aws_subnet.public[*].id  # Use the IDs of the public subnets

  tags = {
    Name = var.alb_name
  }
}

# Security Group for ALB
resource "aws_security_group" "alb_sg" {
  vpc_id = aws_vpc.main.id
  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
  tags = {
    Name = "alb-sg"
  }
}

# ALB Target Group
resource "aws_lb_target_group" "example" {
  name     = "mywebpage-tg"
  port     = 80
  protocol = "HTTP"
  vpc_id   = aws_vpc.main.id
  health_check {
    path                = "/"
    protocol            = "HTTP"
    interval            = 30
    timeout             = 5
    healthy_threshold   = 2
    unhealthy_threshold = 2
  }
  tags = {
    Name = "mywebpage-tg"
  }
}

# ALB Listener
resource "aws_lb_listener" "example" {
  load_balancer_arn = aws_lb.example.arn
  port              = 80
  protocol          = "HTTP"
  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.example.arn
  }
}

# ALB Listener Rule (Optional)
resource "aws_lb_listener_rule" "example" {
  listener_arn = aws_lb_listener.example.arn
  priority     = 100
  condition {
    path_pattern {
      values = ["*"]
    }
  }
  action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.example.arn
  }
}

# Target Group Attachment
resource "aws_lb_target_group_attachment" "example" {
  target_group_arn = aws_lb_target_group.example.arn
  target_id        = aws_instance.example.id
  port             = 80
}

# Outputs
output "vpc_id" {
  description = "The VPC ID"
  value       = aws_vpc.main.id
}

output "alb_arn" {
  description = "The ARN of the ALB"
  value       = aws_lb.example.arn
}

output "alb_dns_name" {
  description = "The DNS name of the ALB"
  value       = aws_lb.example.dns_name
}
