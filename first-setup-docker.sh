#!/bin/bash
set -e

# Update sistem & install git
sudo apt update
sudo apt upgrade -y
sudo apt install -y git ca-certificates curl gnupg lsb-release

# Tambahkan GPG key Docker
sudo install -m 0755 -d /etc/apt/keyrings
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /etc/apt/keyrings/docker.gpg
sudo chmod a+r /etc/apt/keyrings/docker.gpg

# Tambahkan repository Docker
echo \
  "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.gpg] https://download.docker.com/linux/ubuntu \
  $(lsb_release -cs) stable" | \
  sudo tee /etc/apt/sources.list.d/docker.list > /dev/null

# Install Docker Engine & Docker Compose
sudo apt update
sudo apt install -y docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin

# Tambahkan user ke grup docker (agar bisa docker tanpa sudo)
sudo usermod -aG docker $USER

git clone --recurse-submodules https://github.com/AkanTahu/thesis-docker.git

sudo chown -R dida:www-data /home/dida/thesis-docker/rekachain-web/public
sudo chown -R www-data:www-data /home/dida/thesis-docker/rekachain-web/storage
sudo chown -R www-data:www-data /home/dida/thesis-docker/rekachain-web/bootstrap/cache
sudo chmod -R 775 /home/dida/thesis-docker/rekachain-web/storage
sudo chmod -R 775 /home/dida/thesis-docker/rekachain-web/bootstrap/cache

sudo chmod -R 777 /home/dida/thesis-docker/shared-storage/dataset_faces

echo "=== Docker & git terinstall. Silakan logout dan login ulang terminal WSL Anda! ==="
echo "Setelah itu, jalankan:"
echo "  git clone https://github.com/AkanTahu/thesis-docker.git"
echo "  cd thesis-docker"
echo "  docker compose up -d"
