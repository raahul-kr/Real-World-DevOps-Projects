# Project 5 — Kubernetes Deployment

The manifests in `manifests/` deploy the Project 2 image with a rolling update,
resource limits, probes, and a ClusterIP service. The Helm chart provides the same
deployment with configurable image and replica settings.

## Apply locally

```powershell
kubectl apply -f manifests/
kubectl rollout status deployment/devops-demo
kubectl port-forward service/devops-demo 5000:5000
```

The image is a placeholder for a registry tag. Change it before applying:

```powershell
kubectl -n default set image deployment/devops-demo app=ghcr.io/example/devops-demo:sha-CHANGE_ME
```

Do not put registry credentials in manifests. Use an image pull secret managed by the
cluster platform when a private registry is required.
