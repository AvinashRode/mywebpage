# My Web Page Architecture

## Overview
Welcome to the architectural breakdown of our cutting-edge cloud-native application, meticulously designed for performance, scalability, and reliability. This project showcases the integration of various tools and services, enabling robust infrastructure, efficient deployment, and seamless traffic management.
![UntitledDiagram drawio1](https://github.com/user-attachments/assets/ff7b7f91-a2ee-4263-bca3-d18f102ef3fa)
## Project Components

### 1. Development and CI/CD Pipeline
- **Terraform**: Infrastructure as code tool ensuring consistent and repeatable environments.
- **Docker Hub**: Container registry for storing and managing Docker images.
- **Jenkins**: Orchestrates continuous integration and deployment, ensuring seamless code integration and delivery.
- **GitHub**: Central hub for code repository, facilitating collaboration and version control.
- **Developer**: Responsible for integrating all these tools to deliver robust and innovative solutions.

### 2. Cloud Infrastructure
- **Amazon Web Services (AWS)**: Backbone of the infrastructure, providing a scalable and reliable environment.
- **Virtual Private Cloud (VPC)**: Ensures secure network isolation for the application.
- **Private and Public Subnets**: Separated to enhance security and performance.
- **NAT Gateway**: Facilitates secure outbound internet traffic for resources in the private subnet.
- **Internet Gateway**: Manages inbound and outbound internet traffic for resources in the public subnet.
- **Route Tables**: Define traffic routing rules within the network, ensuring smooth communication between components.

All infrastructure components are provisioned in AWS using Terraform, ensuring consistency, scalability, and ease of management.

### 3. Kubernetes Ecosystem
- **Amazon EKS (Elastic Kubernetes Service)**: Managed Kubernetes service for orchestrating deployment, scaling, and management of containerized applications.
- **Application Pod**: Hosts the core application, ensuring high availability and scalability.
- **Prometheus Pod**: Monitors application performance and health, providing crucial metrics.
- **Grafana Pod**: Visualizes data from Prometheus, offering actionable insights through interactive dashboards.

### 4. Load Balancing and DNS
- **Application Load Balancer (ALB)**: Distributes incoming traffic across multiple targets, enhancing availability and fault tolerance.
- **Amazon Route 53**: DNS service translating domain names into IP addresses, directing traffic to appropriate resources.
- **Hostinger DNS**: Ensures reliable and fast domain name resolution.

## Workflow

### 1. Development and Deployment
1. Developers commit code to GitHub.
2. Jenkins triggers the CI/CD pipeline, building Docker images and pushing them to Docker Hub.
3. Terraform provisions the necessary infrastructure on AWS.

### 2. Application Deployment
1. The EKS cluster pulls Docker images from Docker Hub.
2. The application, along with monitoring (Prometheus) and visualization (Grafana) pods, is deployed within the EKS cluster.

### 3. Traffic Management
1. Route 53 and Hostinger DNS handle domain name resolution.
2. ALB distributes incoming traffic to the application pods.
3. NAT Gateway and Internet Gateway manage outbound and inbound traffic, respectively.

## Security and Monitoring
Security and monitoring are emphasized at every level of the architecture. The private subnet shields sensitive resources, while Prometheus and Grafana provide comprehensive monitoring and visualization, ensuring the application remains secure and performant.

Feel free to explore, contribute, or use this architecture as a foundation for your own projects. This README provides an overview, but further documentation is available within the repository for more in-depth guidance.
