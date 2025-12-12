# Production Kubernetes DevOps Lab

This repository contains a full end-to-end modern production pipeline:

✔ FastAPI Application  
✔ Docker Image  
✔ Helm deployment (Blue-Green)  
✔ Jenkins CI pipeline  
✔ ArgoCD GitOps CD  
✔ AWS EKS Infrastructure (Terraform)  
✔ Monitoring (Prometheus + Grafana + Loki)

---

### Run Locally

```bash
docker build -t myapp .
docker run -p 8000:8000 myapp
