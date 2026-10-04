# Project 3 — Cloud Deployment

This project describes a repeatable deployment of the containerized application to a
single Ubuntu EC2 instance. It intentionally keeps credentials outside the repository.

## Deployment flow

```text
GitHub Actions -> container registry -> EC2 user-data -> Docker Compose -> Flask
```

The `user-data.sh` script installs Docker, authenticates using an instance role, pulls a
versioned image, and starts it with a restart policy. It is safe to inspect locally and
must be supplied to EC2 through a launch template or the console; it does not contain
access keys.

## Required instance configuration

* Ubuntu 24.04 LTS, at least 1 GiB memory
* Security group allowing TCP 80 from the intended client range and SSH only from an
  administrator IP range
* An instance profile granting read-only access to the chosen container registry
* `IMAGE_URI` and `AWS_REGION` supplied as instance metadata/user-data variables

For production, prefer ECS or EKS over a single instance. This project is deliberately
small so the deployment lifecycle can be understood end to end.

## Operational checks

```bash
docker compose -f /opt/devops-demo/compose.yaml ps
curl http://localhost/health
docker compose -f /opt/devops-demo/compose.yaml logs --tail=100
```

Never commit rendered user-data containing credentials or private registry tokens.
