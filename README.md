# Project Overview

This project demonstrates the deployment and management of a MySQL RDS database within an AWS Virtual Private Cloud (VPC) using Terraform. The setup includes the creation of necessary networking infrastructure, deployment of a Kubernetes (EKS) cluster, and deployment of a web application using Docker.

## Steps to Create the Infrastructure

1. ### Create Our Remote Backend

- Set up a remote backend to store Terraform configuration.
- Create an S3 bucket using Terraform for state file storage.
- Create a DynamoDB table using Terraform to manage state file locking.

2. ### Create Our Main Infrastructure

#### VPC Setup:

- One VPC.
- 2 private and 2 public subnets across 2 different availability zones.

#### Networking Components:

- Internet Gateway for outbound internet access.
- NAT Gateway for secure internet access from private subnets.
- Route tables, routes, and route table associations.

- #### Security:
- Security groups for controlling network traffic.
- A Bastion Host (EC2) in the public subnet for SSH access and downloads.

3. ### Create Our Kubernetes (EKS) Cluster

- Deploy an EKS cluster within the VPC using Terraform.

4. ### Dockerize the Application

- Create a Dockerfile for the application.
- Build and push the Docker image to DockerHub.

5. ### Deploy the Web Application

- Use kubectl to deploy the web application manifest files.
- Create a deployment and a service of type LoadBalancer.

## Conclusion

This project provides a comprehensive setup for deploying a MySQL RDS database, a Kubernetes cluster, and a web application within an AWS VPC, leveraging Terraform and Docker to ensure a robust, scalable, and efficient infrastructure.
