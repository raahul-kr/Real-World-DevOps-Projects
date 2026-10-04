# Project 6 — Jenkins CI/CD

`Jenkinsfile` implements the same quality gate as Project 2 using a declarative
pipeline. Configure a multibranch pipeline to point at this repository and set
`PROJECT_DIR` to `02-github-actions-cicd` if the checkout is the repository root.

The pipeline runs tests, builds the image, and removes the local image in `post`.
Registry publishing is intentionally a separately-approved stage so a pull request
cannot publish an unreviewed image.
