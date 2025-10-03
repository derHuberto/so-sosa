#!/bin/bash

set -e

sudo apt update && sudo apt upgrade -y

sudo apt install -y apt-transport-https ca-certificates curl gnupg lsb-release

curl -fsSL https://get.docker.com -o get-docker.sh
sudo sh get-docker.sh
rm get-docker.sh

sudo usermod -aG docker fpuna

DOCKER_COMPOSE_VERSION="2.28.2"
DC_BIN="/usr/local/bin/docker-compose"

echo "🔹 Instalando Docker Compose v$DOCKER_COMPOSE_VERSION..."
sudo curl -L "https://github.com/docker/compose/releases/download/v$DOCKER_COMPOSE_VERSION/docker-compose-$(uname -s)-$(uname -m)" -o $DC_BIN
sudo chmod +x $DC_BIN


if command -v docker-compose >/dev/null 2>&1; then
    echo 'Success'
else
 
    exit 1
fi
