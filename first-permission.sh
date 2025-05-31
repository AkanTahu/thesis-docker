sudo chown -R dida:www-data /home/dida/thesis-docker/rekachain-web/public
sudo chown -R www-data:www-data /home/dida/thesis-docker/rekachain-web/storage
sudo chown -R www-data:www-data /home/dida/thesis-docker/rekachain-web/bootstrap/cache
sudo chmod -R 775 /home/dida/thesis-docker/rekachain-web/storage
sudo chmod -R 775 /home/dida/thesis-docker/rekachain-web/bootstrap/cache

sudo chmod -R 777 /home/dida/thesis-docker/shared-storage/dataset_faces