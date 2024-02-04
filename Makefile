init:
	cp example.env .env

build:
	docker compose build

shell:
	docker compose run --rm main bash

run:
	docker compose run --rm main

test:
	docker compose run --rm main bundle exec rspec
