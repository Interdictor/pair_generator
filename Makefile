build:
	docker compose build

shell:
	docker compose run --rm main bash

test:
	docker compose run --rm main
