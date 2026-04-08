TechCorp AWS Infrastructure Deployment (Terraform)

Overview

This project provisions a complete, highly available web application infrastructure on AWS using Terraform.

The architecture is designed to meet the following business requirements:
	•	High availability across multiple Availability Zones
	•	Secure network isolation using public and private subnets
	•	Scalable web application layer behind a load balancer
	•	Secure administrative access via a bastion host

Architecture Components

The infrastructure includes:
	•	VPC
	•	CIDR: 10.0.0.0/16
	•	DNS hostnames and support enabled
	•	Subnets
	•	Public Subnets:
	•	10.0.1.0/24 (AZ1)
	•	10.0.2.0/24 (AZ2)
	•	Private Subnets:
	•	10.0.3.0/24 (AZ1)
	•	10.0.4.0/24 (AZ2)
	•	Networking
	•	Internet Gateway (for public access)
	•	NAT Gateways (for private subnet internet access)
	•	Route Tables and Associations
	•	Security Groups
	•	Bastion: SSH access restricted to user IP
	•	Web: HTTP/HTTPS from anywhere, SSH from bastion
	•	Database: PostgreSQL access from web servers, SSH from bastion
	•	EC2 Instances
	•	Bastion Host (public subnet with Elastic IP)
	•	2 Web Servers (private subnets with Apache)
	•	1 Database Server (private subnet with PostgreSQL)
	•	Application Load Balancer
	•	Internet-facing
	•	Distributes traffic across web servers
	•	Health checks configured

Prerequisites

Before deploying, i ensured i had:
	•	AWS account
	•	AWS CLI configured (aws configure)
	•	Terraform installed
	•	SSH key pair created in AWS
	•	Your public IP address

Deployment Steps
1.	Clone the repository:
git clone <your-repo-url>
cd terraform-assessment

2.	Create your variable file:
cp terraform.tfvars.example terraform.tfvars

3.	Update values in terraform.tfvars:
region   = "us-east-1"
key_name = "your-keypair-name"
my_ip    = "YOUR-IP/32"

4.	Initialize Terraform:
terraform init

5.	Review execution plan:
terraform plan

6.	Apply the infrastructure:
terraform apply


Accessing the Infrastructure

SSH to Bastion Host
ssh -i techcorp-bastion-key.pem ec2-user@<BASTION_PUBLIC_IP>

SSH to Private Instances (via Bastion)
ssh ec2-user@<PRIVATE_IP>
Once connected to the bastion host, you can access private instances:

ssh ec2-user@<WEB_SERVER_PRIVATE_IP>
ssh ec2-user@<DB_SERVER_PRIVATE_IP>

Verify Web Server
After connecting to a web server:

curl localhost

Verify Database Server
After connecting to the database server:

sudo -i -u postgres
psql -c "\l"
This should display the list of PostgreSQL databases.

---

### Access Application via Load Balancer

```md
Open the Load Balancer DNS in your browser:

http://<LOAD_BALANCER_DNS_NAME>

Refreshing the page should show different instance IDs, confirming load balancing.

Outputs
Terraform outputs include:
- Bastion Public IP
- Load Balancer DNS Name
- VPC ID

To view outputs:

terraform output

Cleanup Instructions:
To destroy all resources and avoid AWS charges:

terraform destroy

Type "yes" when prompted.

Cost Warning:
Note:

This setup uses NAT Gateways which incur hourly charges on AWS.
Ensure you run `terraform destroy` after testing to avoid unnecessary costs.


