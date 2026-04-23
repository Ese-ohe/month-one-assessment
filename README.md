TechCorp AWS Infrastructure Deployment (Terraform)

Overview

This project provisions a highly available, secure, and scalable web application infrastructure on AWS using Terraform.

The solution is designed to simulate a real-world production environment and meets key business requirements such as high availability, network security, controlled access, and load-balanced traffic distribution.

Business Requirements Addressed:
•	High availability across multiple Availability Zones
•	Secure network isolation using public and private subnets
•	Load balancing for web traffic
•	Secure administrative access via a bastion host
•	Scalable architecture to support business growth

    Architecture Summary

The infrastructure is deployed within a custom VPC and spans two Availability Zones for resilience.

Core Components:

	•	VPC
	•	CIDR Block: 10.0.0.0/16
	•	DNS hostnames and DNS support enabled
	•	Subnets
	•	Public Subnets:
	•	10.0.1.0/24 (AZ1)
	•	10.0.2.0/24 (AZ2)
	•	Private Subnets:
	•	10.0.3.0/24 (AZ1)
	•	10.0.4.0/24 (AZ2)
	•	Networking
	•	Internet Gateway (for public access)
	•	NAT Gateways (one per public subnet for high availability)
	•	Route Tables and Associations
	•	Security Groups
	•	Bastion SG: SSH (22) allowed only from user IP
	•	Web SG: HTTP (80), HTTPS (443) from anywhere, SSH from Bastion
	•	Database SG: PostgreSQL (5432) from Web SG, SSH from Bastion
	•	Compute (EC2)
	•	Bastion Host (public subnet with Elastic IP)
	•	2 Web Servers (private subnets, Apache installed)
	•	1 Database Server (private subnet, PostgreSQL installed)
	•	Application Load Balancer
	•	Internet-facing
	•	Distributes traffic across web servers
	•	Health checks configured

⸻

Design Decisions:

•	Multi-AZ Deployment
Ensures high availability and fault tolerance in case of AZ failure.
•	Private Subnets for Application & Database
Improves security by preventing direct internet access.
•	NAT Gateways
Allow outbound internet access for private instances (e.g., package updates).
•	Bastion Host
Provides controlled and secure SSH access to private resources.
•	Application Load Balancer (ALB)
Distributes incoming traffic and improves scalability and reliability.

Project Structure:
terraform-assessment/
├── main.tf
├── variables.tf
├── outputs.tf
├── terraform.tfvars.example
├── user_data/
│   ├── web_server_setup.sh
│   └── db_server_setup.sh
├── evidence/
└── README.md


Prerequisites:

Before deployment, ensure you have:
	•	AWS Account
	•	AWS CLI configured (aws configure)
	•	Terraform installed
	•	SSH Key Pair created in AWS
	•	Your public IP address

Deployment Steps

1. Clone the Repository
git clone <your-repo-url>
cd terraform-assessment

2. Create Variables File
cp terraform.tfvars.example terraform.tfvars

3. Update Variables

Edit terraform.tfvars:
region   = "us-east-1"
key_name = "your-keypair-name"
my_ip    = "YOUR-IP/32"

4. Initialize Terraform
terraform init

5. Review Execution Plan
terraform plan

6. Apply Infrastructure
terraform apply
Type yes when prompted.


Accessing the Infrastructure:

SSH to Bastion Host
ssh -i techcorp-bastion-key.pem ec2-user@<BASTION_PUBLIC_IP>


Access Private Instances (via Bastion)

Once connected to the bastion host:
ssh ec2-user@<WEB_SERVER_PRIVATE_IP>
ssh ec2-user@<DB_SERVER_PRIVATE_IP>

Verification Steps:

Verify Web Server

On a web server:
curl localhost

You should see a page displaying the instance ID.

Verify Database Server
sudo -i -u postgres
psql -c "\l"
This should display PostgreSQL databases.

Access Application via Load Balancer

Open the Load Balancer DNS in your browser:
http://<LOAD_BALANCER_DNS_NAME>

Refreshing the page should show different instance IDs, confirming load balancing.

Terraform Outputs

The following outputs are available:
	•	Bastion Public IP
	•	Load Balancer DNS Name
	•	VPC ID

To view: terraform output

Deployment Evidence

Screenshots of deployment and verification steps are available in the evidence/ folder, including:
	•	Terraform plan
	•	Terraform apply
	•	AWS resources
	•	SSH access (Bastion, Web, DB)
	•	PostgreSQL verification
	•	Load balancer output

    Terraform State (Important Note)

The terraform.tfstate file contains infrastructure details and may include sensitive information.

Best Practice:
Do NOT commit this file to GitHub. It should be included in .gitignore.

Cleanup Instructions:
To avoid AWS charges, destroy all resources after testing:
terraform destroy
Type yes when prompted.

Features Implemented:
	•	High availability across multiple AZs
	•	Secure VPC architecture with subnet isolation
	•	Bastion-based SSH access
	•	Load-balanced web tier
	•	Apache web server automation
	•	PostgreSQL database setup
	•	Infrastructure as Code using Terraform

## Note on Terraform State
The `terraform.tfstate` file is included in this repository to satisfy the assessment submission requirement.
At the time of submission, the state file contained infrastructure metadata such as resource IDs, IP addresses, and configuration details used for this project. It did not intentionally include application secrets, passwords, or private keys.
In a real-world production environment, Terraform state files should not typically be committed to a public repository because they may contain sensitive infrastructure metadata.


Final Note

This project demonstrates practical implementation of AWS infrastructure using Terraform, following industry best practices for security, scalability, and reliability.

