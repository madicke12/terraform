# Kubernetes Infrastructure with Terraform

This project provisions a complete Kubernetes-based application stack using [Terraform](https://www.terraform.io/). It includes frontend and backend services, a PostgreSQL database, and an NGINX ingress controller, all managed as Kubernetes resources.

## Project Structure

```
.
├── main.tf                # Main Terraform configuration
├── variables.tf           # Global variables (e.g., DB credentials)
├── Jenkinsfile            # CI/CD pipeline for Terraform
├── modules/               # Reusable Terraform modules
│   ├── backend/           # Backend deployment and service
│   ├── frontend/          # Frontend deployment and service
│   ├── ingress/           # Ingress resource for routing
│   └── postgres/          # PostgreSQL deployment, PVC, and service
├── .terraform/            # Terraform state and provider cache (ignored by git)
├── terraform.tfstate      # Terraform state file (ignored by git)
├── .gitignore             # Git ignore rules
```

## Components

- **Frontend**: Deploys a frontend application as a Kubernetes Deployment and NodePort Service.
- **Backend**: Deploys a backend application as a Kubernetes Deployment and NodePort Service.
- **Postgres**: Deploys a PostgreSQL database with persistent storage and secrets for credentials.
- **Ingress**: Configures NGINX ingress to route traffic to frontend and backend services.
- **Namespace**: Creates a dedicated Kubernetes namespace for all resources.

## Prerequisites

- [Terraform 1.2.0+](https://www.terraform.io/downloads.html)
- [kubectl](https://kubernetes.io/docs/tasks/tools/)
- Access to a Kubernetes cluster (e.g., [Minikube](https://minikube.sigs.k8s.io/docs/))
- NGINX Ingress Controller installed in your cluster

## Usage

1. **Clone the repository**

   ```sh
   git clone <repo-url>
   cd <repo-directory>
   ```

2. **Configure Kubernetes context**

   Ensure your `kubectl` context is set to your target cluster (default: `minikube`).

3. **Initialize Terraform**

   ```sh
   terraform init
   ```

4. **Review the plan**

   ```sh
   terraform plan
   ```

5. **Apply the configuration**

   ```sh
   terraform apply -auto-approve
   ```

6. **Access the applications**

   - Frontend: `http://<minikube-ip>:30517`
   - Backend API: `http://<minikube-ip>:30519`
   - Ingress: Configure `/etc/hosts` to map `frontend.local` and `api.local` to your cluster IP.

## CI/CD

A [Jenkinsfile](Jenkinsfile) is provided for automating Terraform operations in a Jenkins pipeline, including notifications on build status.

## Customization

- Edit [variables.tf](variables.tf) to change database credentials.
- Modify module variables in [main.tf](main.tf) to adjust image names, ports, and resource limits.

## Clean Up

To destroy all resources:

```sh
terraform destroy
```

## License

This project is for educational/demo purposes.

---

**Author:** Madicke Cisse  
**Contact:** cissemadicke8@gmail.com