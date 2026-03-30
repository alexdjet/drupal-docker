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
	# Если composer.json нет, скачиваем во временную папку и переносим
	docker-compose exec php composer create-project drupal/recommended-project temp_drupal --no-interaction
	docker-compose exec php sh -c "mv temp_drupal/* temp_drupal/.* . 2>/dev/null || true"
	docker-compose exec php composer install

	# Устанавливаем Drush прямо в проект (локально, не глобально)
	docker-compose exec php composer require drush/drush
	# Обновляем зависимости, чтобы убедиться, что всё в vendor
	docker-compose exec php composer install

	# Установка БД через Drush
	docker-compose exec php ./vendor/bin/drush site:install standard \
		--db-url=mysql://$(MYSQL_USER):$(MYSQL_PASSWORD)@db/$(MYSQL_DATABASE) \
		--account-name=$(ACCOUNT_NAME) --account-pass=$(ACCOUNT_PASS) -y
	# Права доступа
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


