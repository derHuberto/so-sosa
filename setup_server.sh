#!/bin/bash
# setup_server.sh
# Script para preparar host, instalar Docker y levantar contenedores Ollama + Nginx

set -e

sudo apt update && sudo apt upgrade -y

sudo apt install ufw -y
sudo ufw allow OpenSSH
sudo ufw enable

USERNAME="fpuna"
if ! id -u $USERNAME >/dev/null 2>&1; then
    sudo adduser --disabled-password --gecos "" $USERNAME
    sudo usermod -aG sudo $USERNAME
fi

sudo apt install -y \
    apt-transport-https \
    ca-certificates \
    curl \
    gnupg \
    lsb-release

curl -fsSL https://get.docker.com -o get-docker.sh
sudo sh get-docker.sh
sudo usermod -aG docker $USERNAME
rm get-docker.sh

DOCKER_COMPOSE_VERSION="2.28.2"
sudo curl -L "https://github.com/docker/compose/releases/download/v$DOCKER_COMPOSE_VERSION/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose
sudo chmod +x /usr/local/bin/docker-compose

mkdir -p ~/docker/ollama
mkdir -p ~/docker/nginx/html

echo "<!DOCTYPE html>
<html>
<head>
<title>Mi Nginx</title>
</head>
<body>
<h1>¡Nginx funciona!</h1>
<p>Servidor configurado con Docker y script automático.</p>
</body>
</html>" > ~/docker/nginx/html/index.html

cat <<EOF > ~/docker/docker-compose.yml
version: '3.8'

services:
  ollama:
    image: debian:12
    container_name: ollama
    tty: true
    stdin_open: true
    command: bash -c "apt update && apt install -y curl && curl -fsSL https://ollama.com/install.sh | sh && ollama pull deepseek-r1:1.5b && bash"

  nginx:
    image: nginx:latest
    container_name: nginx
    ports:
      - "80:80"
    volumes:
      - ./nginx/html:/usr/share/nginx/html:ro
EOF

cd ~/docker
docker-compose up -d

echo "Usuario '$USERNAME' creado, UFW activo, Docker instalado, contenedores Ollama y Nginx corriendo."
