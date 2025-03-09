# Shortner

This application is intended to shorten URLs.

## Getting started

Officially supported version is 24.04.2 LTS. If you wish to use other versions, make the necessary adaptations according to your OS.

## First steps

```shell
git clone git@github.com:ricardopacheco/developer-challenges.git shortner
cd shortner
cp lib/templates/.env.development.template .env
cp lib/templates/.env.test.template .env.test
```

> Configure if needed the environment variables according to your development and testing environment.

## Setup

You will need to have docker and docker-compose installed to run the project correctly. Install according to your OS's official documentation:

- [`docker`](https://docs.docker.com/engine/install/)
- [`docker-compose`](https://docs.docker.com/compose/install/)

To verify that docker is working correctly, run the `docker --version` and `docker compose --version` commands. If the output of the command is the same like `Docker version 28.0.1, build 068a01e` and `Docker Compose version v2.33.1-desktop.1` your installation should be ok. After thatm we can follow the normal setup of a rails application with docker:

```shell
# This command may take a while depending on your internet speed.
# This will create an intermediate container that will open a bash for us
docker compose run --rm app bundle exec rails db:prepare
```

Now just start your full stack using `docker compose up`. You should be able to see the application running [locally](http://localhost:4000)

To run suite of tests:

```shell
docker compose run --rm app /bin/bash
CI=true RAILS_ENV=test bundle exec rspec .
```

## Utils

Here is a list of the most useful commands used in everyday life.

```shell
# Restart a container without restarting all the other ones:
docker compose restart app
# Stop all containers with compose
docker compose stop
# Remove all containers with compose
docker compose rm
# Stop and remove all containers with compose
docker compose down
# Stop all containers (with or without compose). This is useful in case some
# unexpected container is running and disturbing the workflow.
docker stop -f $(docker ps -a -q)
# Remove all containers (with or without compose). This is useful in case some
# unexpected container is running and disturbing the workflow.
docker rm -f $(docker ps -a -q)
# Install ping tool (for debug network issues)
apt install iputils-ping
# Install ifconfig tool (for debug network issues)
apt install net-tools
```

## Postman

To make it easier to check endpoints, a collection is available for postman.
[Click here](https://learning.postman.com/docs/getting-started/importing-and-exporting/importing-and-exporting-overview/) to import this collection using the official postman documentation.
