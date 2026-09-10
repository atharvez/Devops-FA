# 🚀 Git-Based Infrastructure as Code with Terraform & Docker

A multi-environment Infrastructure as Code (IaC) project that uses **Terraform** to provision and manage containerized applications with **Docker** across separate **QA, UAT, and PROD environments**.

The project follows a **DRY (Don't Repeat Yourself)** infrastructure approach: a single Terraform configuration is reused across environments, while environment-specific settings are provided through `.tfvars` files.

---

## 📌 Overview

Managing infrastructure separately for development, testing, and production environments can lead to duplicated configuration, inconsistencies, and deployment errors.

This project demonstrates how **Terraform + Docker + Git** can be used to create a consistent, repeatable, and version-controlled infrastructure workflow.

### Core idea

```text
                    ┌─────────────────────┐
                    │   Terraform Code    │
                    │     main.tf         │
                    │   variables.tf      │
                    └──────────┬──────────┘
                               │
                 ┌─────────────┼─────────────┐
                 │             │             │
                 ▼             ▼             ▼
          ┌────────────┐ ┌────────────┐ ┌────────────┐
          │     QA     │ │    UAT     │ │    PROD    │
          │ qa.tfvars  │ │ uat.tfvars │ │prod.tfvars │
          └─────┬──────┘ └─────┬──────┘ └─────┬──────┘
                │              │              │
                ▼              ▼              ▼
          ┌────────────┐ ┌────────────┐ ┌────────────┐
          │  Docker    │ │  Docker    │ │  Docker    │
          │ Containers │ │ Containers │ │ Containers │
          └────────────┘ └────────────┘ └────────────┘
```

---

## ✨ Features

* **Infrastructure as Code** using Terraform
* **Containerized deployment** using Docker
* Separate **QA, UAT, and PROD** environments
* Environment-specific configuration using `.tfvars`
* Reusable Terraform configuration
* Automated Docker network creation
* Backend and frontend container provisioning
* Environment-specific ports and configuration
* Git-based infrastructure version control
* Repeatable deployment and teardown
* Easy environment switching without modifying Terraform source code

---

## 🛠️ Technology Stack

| Technology          | Purpose                                     |
| ------------------- | ------------------------------------------- |
| **Terraform**       | Infrastructure provisioning and management  |
| **Docker**          | Containerization and application runtime    |
| **Git**             | Version control and infrastructure history  |
| **HCL**             | Terraform configuration language            |
| **Docker Provider** | Allows Terraform to manage Docker resources |

---

## 📂 Project Structure

```text
project/
│
├── terraform/
│   │
│   ├── main.tf
│   ├── variables.tf
│   ├── outputs.tf
│   ├── providers.tf
│   │
│   └── environments/
│       ├── qa.tfvars
│       ├── uat.tfvars
│       └── prod.tfvars
│
├── frontend/
│   └── ...
│
├── backend/
│   └── ...
│
└── README.md
```

> The exact application files may vary depending on the implementation.

---

# 🏗️ Infrastructure Architecture

The infrastructure consists of two primary application components:

```text
                         Terraform
                             │
                             ▼
                 ┌─────────────────────┐
                 │   Docker Provider   │
                 └──────────┬──────────┘
                            │
                 ┌──────────▼──────────┐
                 │  Docker Network     │
                 │    app_network      │
                 └──────────┬──────────┘
                            │
              ┌─────────────┴─────────────┐
              │                           │
              ▼                           ▼
      ┌───────────────┐           ┌───────────────┐
      │    Frontend   │           │    Backend    │
      │    Container  │           │    Container  │
      └───────────────┘           └───────────────┘
```

Terraform manages the Docker infrastructure instead of requiring containers and networks to be created manually.

---

# 🌎 Environment Management

The same Terraform configuration is used for all environments.

Only the variable values change.

```text
                 Same Terraform Code
                         │
          ┌──────────────┼──────────────┐
          │              │              │
          ▼              ▼              ▼
      qa.tfvars      uat.tfvars      prod.tfvars
          │              │              │
          ▼              ▼              ▼
         QA             UAT            PROD
```

This prevents unnecessary duplication and ensures that environments follow the same infrastructure structure.

### Example

```hcl
# qa.tfvars

environment = "qa"

frontend_host_port = 8081
backend_host_port  = 5001
```

A different environment can use different values:

```hcl
# uat.tfvars

environment = "uat"

frontend_host_port = 8082
backend_host_port  = 5002
```

The Terraform source code remains unchanged.

---

# ⚙️ Prerequisites

Before running the project, install:

* [Terraform](https://developer.hashicorp.com/terraform/downloads)
* [Docker Desktop](https://www.docker.com/products/docker-desktop/)
* Git

Verify the installations:

```bash
terraform --version
docker --version
git --version
```

Make sure Docker Desktop is running.

Verify Docker:

```bash
docker ps
```

If Docker is running correctly, the command should return the container list.

---

# 🚀 Getting Started

## 1. Clone the repository

```bash
git clone <repository-url>
cd <repository-name>
```

---

## 2. Navigate to Terraform

```bash
cd terraform
```

---

## 3. Initialize Terraform

```bash
terraform init
```

This initializes Terraform and downloads the required provider.

---

## 4. Validate the configuration

```bash
terraform validate
```

---

## 5. Review the execution plan

For QA:

```bash
terraform plan -var-file="environments/qa.tfvars"
```

For UAT:

```bash
terraform plan -var-file="environments/uat.tfvars"
```

For PROD:

```bash
terraform plan -var-file="environments/prod.tfvars"
```

---

# ▶️ Deploying Environments

## QA

```bash
terraform apply -var-file="environments/qa.tfvars"
```

Confirm the deployment when Terraform asks for approval.

---

## UAT

```bash
terraform apply -var-file="environments/uat.tfvars"
```

---

## PROD

```bash
terraform apply -var-file="environments/prod.tfvars"
```

---

# 🔍 Verify Deployment

After deployment:

```bash
docker ps
```

You should see the application containers created by Terraform.

For example:

```text
CONTAINER ID   IMAGE       PORTS
xxxxxxxx       frontend    0.0.0.0:8081->...
xxxxxxxx       backend     0.0.0.0:5001->...
```

The exact ports depend on the selected environment configuration.

---

# 🌐 Accessing the Application

For QA, for example:

```text
Frontend → http://localhost:8081
Backend  → http://localhost:5001
```

For UAT and PROD, use the ports configured in their respective `.tfvars` files.

You can also test the services using:

```bash
curl http://localhost:8081
```

and:

```bash
curl http://localhost:5001
```

---

# 🧹 Destroying Infrastructure

Terraform can also remove the infrastructure it created.

For QA:

```bash
terraform destroy -var-file="environments/qa.tfvars"
```

For UAT:

```bash
terraform destroy -var-file="environments/uat.tfvars"
```

For PROD:

```bash
terraform destroy -var-file="environments/prod.tfvars"
```

This demonstrates the complete Infrastructure as Code lifecycle:

```text
                ┌──────────────┐
                │ Terraform    │
                │     Init     │
                └──────┬───────┘
                       ▼
                ┌──────────────┐
                │    Plan      │
                └──────┬───────┘
                       ▼
                ┌──────────────┐
                │    Apply     │
                └──────┬───────┘
                       ▼
                ┌──────────────┐
                │   Docker     │
                │ Infrastructure│
                └──────┬───────┘
                       │
                       ▼
                ┌──────────────┐
                │   Destroy    │
                └──────────────┘
```

---

# 🔄 Git-Based Infrastructure

Git is used to maintain the infrastructure configuration and track changes over time.

Example workflow:

```bash
git add .
git commit -m "Add Terraform infrastructure"
git commit -m "Add environment configurations"
git commit -m "Configure Docker containers"
git commit -m "Add QA UAT and PROD environments"
git push
```

This provides:

* Version history
* Change tracking
* Collaboration
* Rollback capability
* Infrastructure auditability

Infrastructure changes become reviewable code changes rather than undocumented manual operations.

---

# 💡 Why Terraform?

Without Terraform, an administrator might manually:

```text
Create Network
     ↓
Build Image
     ↓
Create Container
     ↓
Configure Ports
     ↓
Configure Environment
     ↓
Repeat for every environment
```

With Terraform:

```text
Terraform Configuration
          ↓
    Environment File
          ↓
    terraform apply
          ↓
 Infrastructure Created
```

This makes infrastructure **repeatable, consistent, and easier to maintain**.

---

# 🎯 Key IaC Principle

The central design principle of this project is:

> **One infrastructure definition, multiple environments.**

Instead of creating separate Terraform files for QA, UAT, and PROD, the project uses:

```text
             Terraform Configuration
                       │
          ┌────────────┼────────────┐
          ▼            ▼            ▼
       QA Vars      UAT Vars     PROD Vars
          │            │            │
          ▼            ▼            ▼
         QA           UAT          PROD
```

This significantly reduces configuration duplication and makes infrastructure changes easier to manage.

---

# 📊 Environment Comparison

| Environment | Configuration | Purpose                 |
| ----------- | ------------- | ----------------------- |
| QA          | `qa.tfvars`   | Testing and validation  |
| UAT         | `uat.tfvars`  | User acceptance testing |
| PROD        | `prod.tfvars` | Production deployment   |

All three environments share the same Terraform infrastructure definition.

---

# 🧪 Validation Checklist

Before considering the deployment complete:

```text
☑ Terraform initialized
☑ Terraform configuration validated
☑ Docker Desktop running
☑ Terraform plan successful
☑ QA deployed
☑ UAT deployed
☑ PROD deployed
☑ Containers verified with docker ps
☑ Frontend tested
☑ Backend tested
☑ Infrastructure successfully destroyed
☑ Git history maintained
```

---

# 🔮 Future Enhancements

Potential improvements include:

* CI/CD integration with GitHub Actions
* Remote Terraform state management
* Terraform modules for improved reusability
* Docker image version management
* Automated testing
* Infrastructure security scanning
* Cloud deployment support
* Monitoring and logging
* Secrets management
* Automated environment promotion

---

# 🎓 Learning Outcomes

This project demonstrates practical understanding of:

* Infrastructure as Code
* Terraform fundamentals
* Terraform providers
* Variables and `.tfvars`
* Environment-specific infrastructure
* Docker containerization
* Container networking
* Infrastructure lifecycle management
* Git-based infrastructure workflows
* DRY infrastructure design
* Deployment and teardown automation

---

# 👨‍💻 Project

**Git-Based Infrastructure as Code with Terraform & Docker**

Built to demonstrate how infrastructure can be **defined as code, version controlled with Git, and consistently deployed across multiple environments** using reusable Terraform configuration.
