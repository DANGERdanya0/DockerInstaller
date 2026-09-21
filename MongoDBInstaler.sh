#!/usr/bin/env bash
set -euo pipefail

echo "Обновление списка пакетов..."
apt update

echo "Установка зависимостей..."
apt install -y gnupg curl

echo "Скачивание и импорт GPG-ключа MongoDB..."
curl -fsSL https://pgp.mongodb.com/server-6.0.asc | \
  gpg --dearmor -o /usr/share/keyrings/mongodb-server-6.0.gpg

if [[ ! -f /usr/share/keyrings/mongodb-server-6.0.gpg ]]; then
  echo "Ошибка: не удалось создать GPG-ключ." >&2
  exit 1
fi

echo "Добавление репозитория MongoDB..."
UBUNTU_CODENAME=$(lsb_release -cs)
echo "deb [signed-by=/usr/share/keyrings/mongodb-server-6.0.gpg] https://repo.mongodb.org/apt/ubuntu ${UBUNTU_CODENAME}/mongodb-org/6.0 multiverse" | \
  tee /etc/apt/sources.list.d/mongodb-org-6.0.list

echo "Обновление списка пакетов с новым репозиторием..."
apt update

echo "Установка mongosh..."
apt install -y mongodb-mongosh

echo "mongosh установлен."