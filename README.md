# CUPRA DOCKER

## Building
Build containers and project by running `setup.sh`.

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
