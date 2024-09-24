SHELL := /usr/bin/env bash -o errexit -o pipefail -o nounset

init: ## Run the playbook and setup the server
	@if [ ! -f inventory/hosts.ini ]; then \
		echo "Error: inventory/hosts.ini file not found. Please create it from inventory/hosts.ini.example."; \
		exit 1; \
	fi
	ANSIBLE_CONFIG=ansible.cfg ansible-playbook -i inventory/hosts.ini playbooks/main.yml

MAKEFLAGS += --always-make
.DEFAULT_GOAL := help

help:
	@grep -Eh '^[a-zA-Z_-]+:.*?##? .*$$' $(MAKEFILE_LIST) | awk 'BEGIN {FS = ":.*?##? "}; {printf "\033[36m%-30s\033[0m %s\n", $$1, $$2}'
