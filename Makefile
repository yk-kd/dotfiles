DOTPATH := $(realpath $(dir $(lastword $(MAKEFILE_LIST))))
CANDIDATES := $(wildcard .??*)
EXCLUSIONS := .DS_Store .git .gitmodules
DOTFILES := $(filter-out $(EXCLUSIONS), $(CANDIDATES))

.DEFAULT_GOALS := help

all:

list:
	@$(foreach v, $(DOTFILES), /bin/ls -dF $(v);)

deploy:
	@$(foreach v, $(DOTFILES), ln -sfnv $(abspath $(v)) $(HOME)/$(v);)

update:
	git pull origin master

install: update init deploy 
	@exec $$SHELL

clean:
	@echo 'Remove dot files in your home directory...'
	@-$(foreach v, $(DOTFILES), rm -vrf $(HOME)/$(v);)
	-rm -rf $(DOTPATH)

help: ## Self-documented Makefile
	@grep -E '^[a-zA-Z_-]+:.*?## .*$$' $(MAKEFILE_LIST) \
		| sort \
		| awk 'BEGIN {FS = ":.*?## "}; {printf "\033[36m%-30s\033[0m %s\n", $$1, $$2}'

# vim: se noet ai si ts=4 :
