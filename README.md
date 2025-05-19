git clone --recurse-submodules https://github.com/AkanTahu/thesis-docker.git

TAHAPAN DEPLOYMENT DOCKER by ~chamzal ~work on wsl

!di docker compose jangan lupa mengganti user di volume

SETUP SSG GITHUB

1. copas sh
	~ sudo usermod -aG docker $USER
	~ sudo chown root:root first-setup-docker.sh
	~ sudo chmod +x first-setup-docker.sh

2. git clone

3.
sudo chown -R dida:www-data /home/dida/thesis-docker/rekachain-web/public
sudo chown -R www-data:www-data /home/dida/thesis-docker/rekachain-web/storage
sudo chown -R www-data:www-data /home/dida/thesis-docker/rekachain-web/bootstrap/cache
sudo chmod -R 775 /home/dida/thesis-docker/rekachain-web/storage
sudo chmod -R 775 /home/dida/thesis-docker/rekachain-web/bootstrap/cache

sudo chmod -R 777 /home/dida/thesis-docker/shared-storage/dataset_faces
	