APP_CONTAINER=rekachain-web
FRS_CONTAINER=backend-simple-frs

up:
	docker-compose up -d
	docker-compose exec rekachain-web sh -c "php artisan serve --host=0.0.0.0 & npm run dev"

build:
	docker-compose build --no-cache

rebuild:
	docker-compose down -v && docker-compose build --no-cache && docker-compose up -d

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
	winpty docker exec -it $(APP_CONTAINER) bash

npm-build:
	winpty docker exec -it rekachain-web npm run build

fresh:
	winpty docker exec -it $(APP_CONTAINER) ./wait-for-db.sh && winpty docker exec -it $(APP_CONTAINER) php artisan migrate:fresh --seed

migrate:
	winpty docker exec -it $(APP_CONTAINER) ./wait-for-db.sh && winpty docker exec -it $(APP_CONTAINER) php artisan migrate

config-clear:
	winpty docker exec -it $(APP_CONTAINER) php artisan config:clear && winpty docker exec -it $(APP_CONTAINER) php artisan cache:clear

npm-install:
	winpty docker exec -it $(APP_CONTAINER) npm install

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
	make npm-install
	make npm-build
	make fresh
	make config-clear

rebuild-laravel_V:
	make npm-install
	make npm-build
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
	make npm-install
	make npm-build
	make fresh
	make config-clear



