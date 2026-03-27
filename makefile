include .env
export

# Запуск проекта и сборка
up:
	docker-compose up -d --build

# Остановка проекта
down:
	docker-compose down

# Установка Drupal с нуля (использовать один раз)
install:
	docker-compose exec php composer install
	docker-compose exec php drush site:install standard \
		--db-url=mysql://$(MYSQL_USER):$(MYSQL_PASSWORD)@db/$(MYSQL_DATABASE) \
		--account-name=admin --account-pass=admin -y
	docker-compose exec php chown -R www-data:www-data web/sites/default/files

# Очистка кэша Drupal
cr:
	docker-compose exec php drush cr

# Экспорт конфигурации в Git
cex:
	docker-compose exec php drush cex -y

# Импорт конфигурации
cim:
	docker-compose exec php drush cim -y

# Вход в терминал PHP контейнера
ssh:
	docker-compose exec php bash

# Просмотр логов
logs:
	docker-compose logs -f


