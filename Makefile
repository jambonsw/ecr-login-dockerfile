.PHONY: build clean login push

REPO   := jambonrose/ecr-login
TAG    := $$(git log -1 --pretty=%H | cut -c 1-14)
IMG    := ${REPO}:${TAG}
LATEST := ${REPO}:latest

all:
	@echo 'Available Commands:'
	@$(MAKE) -pRrq -f $(lastword $(MAKEFILE_LIST)) : 2>/dev/null \
		| awk -v RS= -F: '/^# File/,/^# Finished Make data base/ {if ($$1 !~ "^[#.]") {print $$1}}' \
		| sort \
		| egrep -v -e '^[^[:alnum:]]' -e '^$@$$' \
		| xargs -I {} echo '    {}'

build:
	@docker build --pull --no-cache -t ${IMG} .
	@docker tag ${IMG} ${LATEST}

clean:
	@-docker rmi ${REPO} 2>/dev/null # untag the latest
	@-docker images | grep '${REPO}' | awk '{print $$3}' | xargs docker rmi
	@-docker image prune --force

login:
	@docker login -u '$(value DOCKER_USER)' -p '$(value DOCKER_PASSWORD)'

push: login
	@docker push ${REPO}
