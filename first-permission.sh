sudo chown -R $USER:www-data /home/$USER/thesis-docker/rekachain-web/public
sudo chown -R www-data:www-data /home/$USER/thesis-docker/rekachain-web/storage
sudo chown -R www-data:www-data /home/$USER/thesis-docker/rekachain-web/bootstrap/cache
sudo chmod -R 775 /home/$USER/thesis-docker/rekachain-web/storage
sudo chmod -R 775 /home/$USER/thesis-docker/rekachain-web/bootstrap/cache

sudo chmod -R 777 /home/$USER/thesis-docker/shared-storage/dataset_faces
