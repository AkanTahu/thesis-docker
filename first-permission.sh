sudo chown -R ${SUDO_USER:-$USER}:www-data /home/${SUDO_USER:-$USER}/thesis-docker/rekachain-web/public
sudo chown -R www-data:www-data /home/${SUDO_USER:-$USER}/thesis-docker/rekachain-web/storage
sudo chown -R www-data:www-data /home/${SUDO_USER:-$USER}/thesis-docker/rekachain-web/bootstrap/cache
sudo chmod -R 775 /home/${SUDO_USER:-$USER}/thesis-docker/rekachain-web/storage
sudo chmod -R 775 /home/${SUDO_USER:-$USER}/thesis-docker/rekachain-web/bootstrap/cache

sudo chmod -R 777 /home/${SUDO_USER:-$USER}/thesis-docker/shared-storage/dataset_faces
