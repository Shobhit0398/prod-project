 High-Level Goal of the Project
This project implements a GitOps-driven continuous delivery pipeline on Azure Kubernetes Service (AKS) that supports safe production deployments using Canary strategy, with controlled traffic shifting and zero downtime.

🔹 Key Technologies Used
Azure Kubernetes Service (AKS) – Production Kubernetes cluster
Azure Container Registry (ACR) – Stores application Docker images
Helm – Application packaging and templating
Argo CD – GitOps continuous delivery
Argo Rollouts – Advanced deployment strategies (Canary)
NGINX Ingress Controller – External traffic routing
Docker – Application containerization

🔹 End-to-End Flow (Step-by-Step)

1️⃣ Developer Pushes Code
Developer makes a change in the application code.
A new Docker image is built and pushed to Azure Container Registry (ACR) with a new tag.
📦 Example:

myprodacr3.azurecr.io/myapp:<new-tag>

2️⃣ Git Is the Single Source of Truth (GitOps)
The Helm chart (values.yaml / rollout.yaml) is updated with the new image tag.
Changes are committed and pushed to GitHub.
📌 No manual kubectl deployments — everything flows from Git.

3️⃣ Argo CD Detects the Change
Argo CD continuously watches the Git repository.
It detects a difference between:
Desired state (Git)
Actual state (AKS)
🔄 Argo CD automatically syncs the cluster to match Git.

4️⃣ Argo Rollouts Takes Over Deployment
Instead of a normal Kubernetes Deployment, your app is deployed using:

kind: Rollout
strategy: Canary
Argo Rollouts:
Creates two ReplicaSets:
Stable ReplicaSet (current production version)
Canary ReplicaSet (new version)

5️⃣ Canary Traffic Splitting Begins
Traffic is gradually shifted using defined steps:

10% → 25% → 50% → 75% → 100%
✔ This is handled automatically by:
Argo Rollouts
NGINX Ingress
🎯 Only a small percentage of users see the new version initially.

6️⃣ Health & Readiness Checks
Each canary pod:
Pulls the image from ACR
Starts the application
Passes:
Readiness probes
Liveness probes
❌ If a pod fails:
Rollout pauses or fails
Traffic stays on stable pods
✔ If pods are healthy:
Rollout continues automatically

7️⃣ Ingress Routes External Traffic
User requests flow like this:

Browser → NGINX Ingress → Kubernetes Service → Pods
NGINX Ingress routes traffic based on:
Canary weight
Service selectors managed by Argo Rollouts
🌐 Users never see downtime.

8️⃣ Automatic Promotion to Stable
Once 100% traffic is shifted:
Canary version becomes stable
Old ReplicaSet is scaled down
Rollout is marked Healthy
✅ Deployment completed successfully.

9️⃣ Failure Handling (Real Production Safety)
If something goes wrong:
Image pull fails ❌
App crashes ❌
Readiness probe fails ❌
Argo Rollouts:
Automatically halts rollout
Keeps traffic on stable version
Allows manual retry / rollback
This is true production-grade safety.

🔹 Final Result
✔ Zero-downtime deployments ✔ Safe, progressive releases ✔ Git-driven automation ✔ Full visibility & control ✔ Cloud-native best practices
