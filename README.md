# TechCorp AWS Infrastructure Deployment (Terraform)

## Overview

This project provisions a highly available, secure, and scalable web application infrastructure on AWS using Terraform.

The solution simulates a real-world production environment and addresses key requirements such as high availability, network security, controlled access, and load-balanced traffic distribution.

---

## Business Requirements Addressed

- High availability across multiple Availability Zones  
- Secure network isolation using public and private subnets  
- Load balancing for web traffic  
- Secure administrative access via a bastion host  
- Scalable architecture to support business growth  

---

## Architecture Summary

The infrastructure is deployed within a custom VPC and spans two Availability Zones for resilience and fault tolerance.

---

## Core Components

### VPC
- CIDR Block: `10.0.0.0/16`  
- DNS hostnames enabled  
- DNS support enabled  

### Subnets

**Public Subnets**
- `10.0.1.0/24` (AZ1)  
- `10.0.2.0/24` (AZ2)  

**Private Subnets**
- `10.0.3.0/24` (AZ1)  
- `10.0.4.0/24` (AZ2)  

---

## Networking

- Internet Gateway for public internet access  
- NAT Gateways for outbound internet access from private subnets  
- Route tables configured for proper traffic flow  

---

## Security

- Bastion Host for secure SSH access  
- Security Groups restricting access between tiers  
- Database accessible only from web tier  
- No direct internet access to private instances  

---

## Compute Layer

- Bastion Host (public subnet)  
- Web Servers (private subnets across two AZs)  
- Database Server (private subnet)  

---

## Load Balancing

- Application Load Balancer distributes traffic across web servers  
- Target group configured with health checks  
- Improves availability and fault tolerance  

---

## Automation

- Apache installed automatically on web servers using user data  
- PostgreSQL installed and configured on database server  

---

## Features Implemented

- High availability across multiple AZs  
- Secure VPC architecture  
- Bastion-based SSH access  
- Load-balanced web tier  
- Automated server provisioning  
- Infrastructure as Code using Terraform  

---

## Terraform State (Important Note)

The `terraform.tfstate` file is included in this repository to satisfy the assessment submission requirement.

At the time of submission, the state file contained infrastructure metadata such as:
- Resource IDs  
- Public IP addresses  
- Network configuration details  

It does **not intentionally include sensitive data** such as:
- Application secrets  
- Passwords  
- Private keys  

In real-world production environments, Terraform state files should **never be committed to public repositories**, as they may contain sensitive infrastructure data. Instead, remote backends such as AWS S3 with state locking should be used.

---

## Cleanup Instructions

To avoid unnecessary AWS charges, all resources were destroyed after testing using:

```bash
terraform destroy
```

---

## Final Note

This project demonstrates practical implementation of AWS infrastructure using Terraform, following best practices for:
	•	Security
	•	Scalability
	•	Reliability
	•	Infrastructure automation
--- 
