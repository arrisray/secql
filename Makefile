SHELL := /bin/bash

.PHONY: build up down shell clean status

build:
	docker-compose build 

up: export HOST_IP = $(shell ipconfig getifaddr en0)
up:
	open -a XQuartz
	xhost + ${HOST_IP}
	docker-compose up -d

down:
	docker-compose down

clean: export CONTAINER_IDS=$(shell docker ps -qa --no-trunc --filter "status=exited")
clean:
	docker rm $(CONTAINER_IDS)

shell:
	docker exec -it secql_ide_1 /bin/bash

status:
	docker ps -a
