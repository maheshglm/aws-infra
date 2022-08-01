SHELL:=/bin/bash
.DEFAULT_GOAL := help

CUSTOMER := mahesh
ENV      := dev

EXECUTABLES = kubectl terraform terragrunt aws
K := $(foreach cmd,$(EXECUTABLES),\
        $(if $(shell which $(cmd)),,$(error "$(cmd) not found in PATH, Please install $(cmd)")))

plan: ## Plan
	@cd mysql && terragrunt plan
	@cd lb_sg && terragrunt plan
	@cd lb && terragrunt plan
	@cd asg_keypair && terragrunt plan
	@cd asg_sg && terragrunt plan
	@cd asg && terragrunt plan

apply: ## Apply
	@cd mysql && terragrunt apply --auto-approve
	@cd lb_sg && terragrunt apply --auto-approve
	@cd lb && terragrunt apply --auto-approve
	@cd asg_keypair && terragrunt apply --auto-approve
	@cd asg_sg && terragrunt apply --auto-approve
	@cd asg && terragrunt apply --auto-approve

destroy: ## Destroy
	@cd asg && terragrunt destroy --auto-approve
	@cd asg_sg && terragrunt destroy --auto-approve
	@cd asg_keypair && terragrunt destroy --auto-approve
	@cd lb_sg && terragrunt destroy --auto-approve
	@cd lb && terragrunt destroy --auto-approve
	@cd mysql && terragrunt destroy --auto-approve

help:
	@awk 'BEGIN {FS = ":.*?## "} /^[a-zA-Z_-]+:.*?## / {printf "\033[36m%30s\033[0m : %s\n", $$1, $$2}' $(MAKEFILE_LIST)
