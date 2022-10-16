# --------------------------------------------------
# standard Makefile preamble see https://tech.davis-hansson.com/p/make/
SHELL := bash
MAKEFLAGS += --warn-undefined-variables
MAKEFLAGS += --no-builtin-rules
.SHELLFLAGS := -eu -o pipefail -c
.ONESHELL:
.DELETE_ON_ERROR:
ifeq ($(origin .RECIPEPREFIX), undefined)
  $(error Your Make does not support .RECIPEPREFIX. Use GNU Make 4.0 or later)
endif
.RECIPEPREFIX = >
# --------------------------------------------------

.PHONY: build publish serve

publish: build
> cd _site
> git init .
> git add . && git commit -m "built site"
> git remote add github git@github.com:billyc/immersion.git
> git push --force github master:gh-pages

build:
> rm -rf _site
> bundle exec jekyll build

serve:
> bundle exec jekyll serve
