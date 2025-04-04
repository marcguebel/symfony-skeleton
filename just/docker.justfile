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