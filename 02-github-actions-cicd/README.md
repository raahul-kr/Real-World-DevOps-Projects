# Project 2 — GitHub Actions CI/CD

This project adds an automated quality gate and container build to the Flask service from Project 1.

## Pipeline

The workflow in `.github/workflows/ci.yml` runs for pushes and pull requests targeting `main`:

1. Checks out the repository.
2. Installs Python 3.13 dependencies with the pip cache enabled.
3. Runs the pytest suite from this project directory.
4. Builds the Docker image.

The workflow uses an explicit `working-directory` so the monorepo layout does not cause the
project's dependency file or tests to be missed.

## Local validation

From `02-github-actions-cicd`:

```powershell
python -m pytest -v
docker build -t github-actions-cicd:local .
docker run --rm -p 5000:5000 github-actions-cicd:local
```

The service exposes `/` and `/health`. The image health check calls `/health` and the
container runs as an unprivileged `appuser`.

## Repository secrets

This workflow does not require cloud credentials. Registry publishing should be added in a
separate release workflow using GitHub Actions environments and short-lived credentials rather
than storing long-lived tokens in the repository.