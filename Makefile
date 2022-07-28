# varibles used by make
SHELL=/bin/bash
COMPOSE_BUILD = docker-compose build
COMPOSE_RUN_GENERIC = docker-compose run --rm
COMPOSE_RUN = docker-compose run --rm base
COMPOSE_UP = docker-compose up
ACTIVATE_PYTHON=. .venv/bin/activate &&

# user input
AWS_PROFILE_NAME ?=this-repo-name

help: _env
	@grep -E '^[1-9a-zA-Z_-]+:.*?## .*$$|(^#--)' $(MAKEFILE_LIST) \
	| awk 'BEGIN {FS = ":.*?## "}; {printf "\033[32m %-43s\033[0m %s\n", $$1, $$2}' \
	| sed -e 's/\[32m #-- /[33m/'

_env:
	@if [ ! -f ./configs.env ]; then \
		echo "No configs.env file found, running setup ..."; \
		make _setup; \
	fi

_setup:
	touch configs.env
	${COMPOSE_RUN_GENERIC} -e AWS_PROFILE_NAME=${AWS_PROFILE_NAME} setup /bin/bash ./setup.sh

#-- Misc
.PHONY: sh
sh: _env ## launch a container with a terminal for adhoc commands (/bin/bash)
	${COMPOSE_RUN} /bin/bash

.PHONY: rebuild_img
rebuild_img: ## rebuild container images used by compose
	${COMPOSE_BUILD}

.PHONY: aws_configure
aws_configure: ## configure aws credentials for this project using profile AWS_PROFILE_NAME
	${COMPOSE_RUN_GENERIC} aws configure --profile ${AWS_PROFILE_NAME}

#-- Manage this Project
.PHONY: clean
clean: ## clean cache files
	echo 'do clean thing'

.PHONY: deps
deps: ## load dependencies, even if foo exists
	${COMPOSE_RUN} make _deps;
.PHONY: deps_check
deps_check:
	@echo "checking for foo"
	@if [ ! -d ./${CDK_DIR}/foo ]; then \
		echo "No foo file found, building deps"; \
		${COMPOSE_RUN} make _deps; \
	fi
_deps:
	echo "do deps"

#-- App Commands

.PHONY: build
build: _env deps_check ## build
	${COMPOSE_RUN} make _build
_build:
	echo "do build"


.PHONY: run
run: _env deps_check ## run
	${COMPOSE_UP} app
_run:
	echo "command to run app"
