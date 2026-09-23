# Project 1 — Dockerize a Web Application

A hands-on DevOps project demonstrating how to containerize a Python Flask web application, test it, build a Docker image, run it with Docker Compose, configure health checks and restart behavior, and publish the image to Docker Hub.

## Architecture

```text
Browser
   |
   | HTTP :5000
   v
Docker Compose
   |
   v
Flask Application
   |
   +---- GET /
   |
   +---- GET /health
```

The application runs inside a Docker container based on `python:3.13-slim`.

## Project Structure

```text
01-dockerize-webapp/
├── app/
│   ├── __init__.py
│   ├── app.py
│   └── templates/
│       └── index.html
├── tests/
│   └── test_app.py
├── README.md
├── requirements.txt
├── Dockerfile
├── .dockerignore
└── compose.yaml
```

## Application

The Flask application provides two endpoints:

### `/`

Displays the DevOps Demo Application web page.

### `/health`

Returns:

```json
{
  "status": "healthy"
}
```

This endpoint is also used by the Docker container health check.

## Local Testing

From the `01-dockerize-webapp` directory:

```powershell
python -m pytest
```

Expected result:

```text
2 passed
```

## Docker Image

Build the Docker image:

```powershell
docker build -t devops-demo:v2 .
```

The image uses:

```dockerfile
FROM python:3.13-slim
```

The application listens on port `5000`.

## Running the Container

Run the container manually:

```powershell
docker run --name devops-demo-container -p 5000:5000 devops-demo:v2
```

Application:

```text
http://localhost:5000
```

Health endpoint:

```text
http://localhost:5000/health
```

For PowerShell, the native curl executable can be used with:

```powershell
curl.exe http://localhost:5000/health
```

## Docker Health Check

The image contains a Docker `HEALTHCHECK` that calls:

```text
http://localhost:5000/health
```

Configuration:

```dockerfile
HEALTHCHECK --interval=30s --timeout=5s --start-period=5s --retries=3 CMD python -c "import urllib.request; urllib.request.urlopen('http://localhost:5000/health')"
```

Container health can be inspected with:

```powershell
docker inspect devops-demo-compose --format="{{json .State.Health}}"
```

A healthy container reports:

```text
"Status":"healthy"
```

## Docker Compose

The application can be started using Docker Compose:

```powershell
docker compose up -d
```

Check the service:

```powershell
docker compose ps
```

Stop and remove the Compose resources:

```powershell
docker compose down
```

The Compose configuration includes:

```yaml
restart: unless-stopped
```

This allows Docker to restart the application after an unexpected process failure.

## Restart Policy Testing

The restart policy was tested by terminating the container's main process:

```powershell
docker exec devops-demo-compose sh -c "kill 1"
```

Docker automatically restarted the container, and the container returned to:

```text
Up ... (healthy)
```

This demonstrates recovery from an unexpected application process termination.

## Container Troubleshooting

Container logs can be viewed with:

```powershell
docker logs devops-demo-compose
```

Container state can be inspected with:

```powershell
docker inspect devops-demo-compose
```

All containers can be listed with:

```powershell
docker ps -a
```

A deliberately broken container command was also tested:

```powershell
docker run --name devops-demo-broken devops-demo:v2 python does-not-exist.py
```

The container exited with a non-zero status because the application process failed.

This demonstrated the difference between:

* Docker successfully creating a container
* The application process successfully running inside the container

## Docker Hub

The versioned image was published to Docker Hub:

```text
theraahul/devops-demo:v2
```

Pull it with:

```powershell
docker pull theraahul/devops-demo:v2
```

The published image was verified by pulling it back from Docker Hub.

Verified image digest:

```text
sha256:ea312d0e96e43c91405d00453c68c40a28c24a317140a098aa66f7ee53955428
```

The local and remote image digests matched.

## DevOps Concepts Demonstrated

* Python Flask application
* Automated testing with pytest
* Dockerfile creation
* Docker image building
* `.dockerignore`
* Container lifecycle management
* Port mapping
* Container logs
* Container inspection
* Failure troubleshooting
* Docker health checks
* Docker Compose
* Restart policies
* Automatic container recovery
* Container image tagging
* Docker Hub authentication
* Container image publishing
* Container image pulling
* Image digest verification

## Outcome

Project 1 demonstrates a complete local containerization workflow:

```text
Develop
   ↓
Test
   ↓
Build Docker Image
   ↓
Run Container
   ↓
Health Check
   ↓
Compose
   ↓
Automatic Recovery
   ↓
Push to Docker Hub
   ↓
Pull and Verify
```
