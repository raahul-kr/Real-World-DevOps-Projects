#!/usr/bin/env bash
set -euo pipefail

: "${IMAGE_URI:?IMAGE_URI must be supplied in instance user data}"
: "${AWS_REGION:?AWS_REGION must be supplied in instance user data}"

apt-get update
apt-get install --yes ca-certificates curl unzip awscli
install -m 0755 -d /etc/apt/keyrings
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | gpg --dearmor -o /etc/apt/keyrings/docker.gpg
chmod a+r /etc/apt/keyrings/docker.gpg
printf '%s\n' \
  "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.gpg] https://download.docker.com/linux/ubuntu \
  $(. /etc/os-release && echo "$VERSION_CODENAME") stable" \
  > /etc/apt/sources.list.d/docker.list
apt-get update
apt-get install --yes docker-ce docker-ce-cli containerd.io docker-compose-plugin
systemctl enable --now docker

install -d -m 0755 /opt/devops-demo
cat > /opt/devops-demo/compose.yaml <<EOF
services:
  app:
    image: ${IMAGE_URI}
    restart: unless-stopped
    ports:
      - "80:5000"
EOF

aws ecr get-login-password --region "${AWS_REGION}" | docker login --username AWS --password-stdin "${IMAGE_URI%%/*}"
docker compose -f /opt/devops-demo/compose.yaml pull
docker compose -f /opt/devops-demo/compose.yaml up -d
