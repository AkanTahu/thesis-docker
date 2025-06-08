APP_CONTAINER=rekachain-web
FRS_CONTAINER=python-frs

up:
	docker-compose up -d
	docker-compose exec rekachain-web sh -c "php artisan serve --host=0.0.0.0 & npm run dev"

build:
	docker-compose build --no-cache
	
rebuild:
	docker compose down -v && docker compose build --no-cache && docker compose up -d

build-laravel:
	docker-compose build rekachain-web

build-db:
	docker-compose build db

rebuild-db:
	docker-compose rm -f db
	docker-compose rm -f phpmyadmin
	docker-compose build --no-cache db
	docker-compose build --no-cache phpmyadmin
	docker-compose up -d db	
	docker-compose up -d phpmyadmin	

bash:
	  docker exec -it $(APP_CONTAINER) bash

fix-permission:
	chmod +x /home/${SUDO_USER:-$USER}/thesis-docker/.docker/rekachain-web/wait-for-db.sh
	chmod -R 777 /home/${SUDO_USER:-$USER}/thesis-docker/rekachain-web/storage
	chmod -R 777 /home/${SUDO_USER:-$USER}/thesis-docker/rekachain-web/bootstrap/cache

npm-build:
	  docker exec -it $(APP_CONTAINER) npm install
	  docker exec -it $(APP_CONTAINER) node node_modules/vite/bin/vite.js build

fresh:
	  docker compose exec rekachain-web composer install
	  docker compose exec rekachain-web cp .env.example .env
	  docker compose exec rekachain-web php artisan key:generate
	  docker exec -it $(APP_CONTAINER) ./wait-for-db.sh  &&   docker exec -it $(APP_CONTAINER) php artisan migrate:fresh --seed
	  make fix-permission

migrate:
	  docker exec -it $(APP_CONTAINER) ./wait-for-db.sh &&   docker exec -it $(APP_CONTAINER) php artisan migrate

config-clear:
	  docker exec -it $(APP_CONTAINER) php artisan optimize:clear

wipe-db:
	rm -rf ./.docker/db/data/*

logs:
	docker-compose logs -f

stop:
	docker-compose down

ps:
	docker-compose ps

logs-pma:
	docker-compose logs -f phpmyadmin

logs-db:
	docker-compose logs -f db

logs-laravel:
	docker-compose logs -f rekachain-web

logs-frs:
	docker-compose logs -f backend-simple-frs

# ========== THE LEGEND ==========
dev:
	make wipe-db
	make up
	sleep 5
	make config-clear
	make fresh

rebuild-laravel:
	make wipe-db
	docker-compose rm -f $(APP_CONTAINER)
	docker-compose build --no-cache $(APP_CONTAINER)
	docker-compose up -d $(APP_CONTAINER)
	sleep 5
	make npm-build
	make fresh
	make config-clear

rebuild-laravel-v:
	make npm-build
	make fresh
	make config-clear

rebuild-fresh-v:
	docker-compose down
	rm -rf /home/akantahu/v3-thesis-wsl/.docker/db/data/*
	docker-compose up -d
	make fresh
	make config-clear	
	

rebuild-pma:
	docker-compose rm -f phpmyadmin
	docker-compose build --no-cache phpmyadmin
	docker-compose up -d phpmyadmin

run:
	docker-compose exec rekachain-web sh -c "php artisan serve --host=0.0.0.0 & npm run dev"
	make npm-build	

rebuild-all:
	make wipe-db
	make rebuild
	sleep 5
	make npm-build
	make fresh
	make config-clear

clean:
	make wipe-db
	docker-compose down -v
	docker-compose build --no-cache
	docker-compose up -d
	make npm-build
	make fresh
	make config-clear

down-up:
	docker compose down
	docker compose up -d



