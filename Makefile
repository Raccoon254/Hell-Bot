include .env

.PHONY: all

build:
	docker build -t HellBot-ui .

run:
	export $(cat .env | xargs)
	docker stop HellBot-ui || true && docker rm HellBot-ui || true
	docker run --name HellBot-ui --rm -e OPENAI_API_KEY=${OPENAI_API_KEY} -p 3000:3000 HellBot-ui

logs:
	docker logs -f HellBot-ui

push:
	docker tag HellBot-ui:latest ${DOCKER_USER}/HellBot-ui:${DOCKER_TAG}
	docker push ${DOCKER_USER}/HellBot-ui:${DOCKER_TAG}