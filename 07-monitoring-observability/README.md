# Project 7 — Monitoring and Observability

This project provides a local Prometheus and Grafana stack. Prometheus scrapes the
application health endpoint and evaluates a basic availability alert. Grafana is
provisioned from files so a fresh environment is reproducible.

```powershell
docker compose up -d
```

* Application: `http://localhost:5000/health`
* Prometheus: `http://localhost:9090`
* Grafana: `http://localhost:3000` (`admin` / `admin` for local learning only)

The compose file uses a local-only password and must not be reused unchanged in
production. Replace it with a secret and place Grafana behind authentication and TLS.
