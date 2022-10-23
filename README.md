# CUPRA DOCKER

## Building
Build containers and project by running `setup.sh`.
Then follow this tutorial: https://medium.com/@gnjokikiarie/laravel-authentication-with-mongodb-e3921ed10c1a

### Steps
- Build containers and run them either with Docker Desktop or by command line:
  ```bash
  #run as deamon
  docker-compose up --build -d
  ```
  ```bash
  #build only
  docker-compose up --build --no-start
  ```
  ```bash
  #build normally
  docker-compose up --build

- After building containers, run the following comands
  ```bash
  git submodule update --init --recursive
  cd src/cupra-tribe/
  sudo docker-compose exec php composer install
  chown -R <user>:http storage
  chmod -R 775 storage
  ```
  After executing each command, remember to also to
  ```bash
  cp .env.template .env
  ```
  and set values as needed
- Init db by running `sudo docker-compose exec php php artisan migrate:fresh`

## Cheat Sheet
- To run a command under a container, use `docker-compose exec <container-name> <command to run> <arguments>`
- To open a shell, simply run `docker-compose exec <container-name> bash`
- To rebuild from scratch every container:
  ```bash
  docker-compose stop
  docker-compose rm
  docker-compose build
  ```
  This is generally not needed, since every change to a container will be handled by Docker itself, simply running `docker-compose build` should be enougth

## How submodule works
git submodules are direct link to a commit of another repository, this means just by cloning this repo you WILL NOT get the latest commit of Cupra Tribe, but the latest "Stable" version of it.
To get the latest commit, cd to `src/cupra-tribe` and run `git pull`
