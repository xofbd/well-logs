SHELL := /bin/bash
PACKAGE_DIR := package

.PHONY: all
all: clean update-lambda

requirements-dev.txt: poetry.lock
	poetry export --format requirements.txt --with=dev > $@

$(PACKAGE_DIR):
	mkdir -p $@

deployment.zip: | $(PACKAGE_DIR)
	PIP_REQUIRE_VIRTUALENV=false pip install \
		--platform manylinux2014_x86_64 \
		--target=$(PACKAGE_DIR) \
		--implementation cp \
		--python-version 3.10 \
		--only-binary=:all: \
		.

	rm -rf $(PACKAGE_DIR)/scipy*
	(cd $(PACKAGE_DIR) && zip -r ../$@ .)
	zip $@ lambda_function.py

.PHONY: update-lambda
update-lambda: deployment.zip
	bin/lambda-update

.PHONY: clean
clean:
	rm -rf $(PACKAGE_DIR) deployment.zip
