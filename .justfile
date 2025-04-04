alias run := up
alias stop := down

exec-in-docker := 'docker exec -it symfony-php'

# ❓ Display this help #
help:
  @just --list

##### START DOCKER SECTION #####
# 🏃 Run the container #
up:
  @docker-compose up -d

# 🛑 Stop the container #
down:
  @docker-compose down

# 🏗️ Build the container #
build:
  @docker-compose build

# 🔄 Restart the container #
restart:
  @just down
  @just up
##### END DOCKER SECTION #####


##### START SYMFONY SECTION #####
# 🎮 Run {{cmd}} commande in symfony console #
console cmd: 
  {{exec-in-docker}} php bin/console {{cmd}}

# 🧹 Cache clear #
cc:
  {{exec-in-docker}} php bin/console cache:clear

# 📜 Create new migration #
db-migration:
  {{exec-in-docker}} php bin/console make:migration

# 🛠️ Execute migration #
db-migrate:
  {{exec-in-docker}} php bin/console cache:clear
##### END SYMFONY SECTION #####


##### START CLEAN CODE SECTION #####
# 🔍 Lint #
lint:
  {{exec-in-docker}} vendor/bin/php-cs-fixer fix src
  @just phpstan
  @just phpmd

# 🛡️ Run phpstan #
phpstan:
  {{exec-in-docker}} vendor/bin/phpstan analyse src

# ⚖️ Run phpmd #
phpmd:
  {{exec-in-docker}} vendor/bin/phpmd src ansi cleancode
##### END CLEAN CODE SECTION #####