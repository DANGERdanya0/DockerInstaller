#!/bin/bash

set -e  # выходим при ошибке

echo "[+] Обновление пакетов..."
sudo apt update

echo "[+] Установка зависимостей..."
sudo apt install -y ca-certificates curl gnupg lsb-release

echo "[+] Добавление GPG-ключа Docker..."
sudo mkdir -p /etc/apt/keyrings
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | \
  sudo gpg --dearmor -o /etc/apt/keyrings/docker.gpg

echo "[+] Добавление репозитория Docker..."
echo \
  "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.gpg] \
  https://download.docker.com/linux/ubuntu \
  $(lsb_release -cs) stable" | \
  sudo tee /etc/apt/sources.list.d/docker.list > /dev/null

echo "[+] Обновление пакетов после добавления репозитория..."
sudo apt update

echo "[+] Установка Docker CE и сопутствующих пакетов..."
sudo apt install -y docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin

echo "[+] Установка Docker Compose (v2)..."
sudo curl -L "https://github.com/docker/compose/releases/latest/download/docker-compose-$(uname -s)-$(uname -m)" \
  -o /usr/local/bin/docker-compose

sudo chmod +x /usr/local/bin/docker-compose

echo "[+] Проверка версии Docker Compose:"
docker-compose --version

echo "[✓] Установка завершена."
