REQUIREMENTS := requirements
SHELL := /bin/bash

clean:
	@rm -rf venv

install: clean
	@virtualenv venv
	@venv/bin/pip -qq install -U pip
	for name in prod dev ; do \
  		venv/bin/pip -qq install -r $(REQUIREMENTS)/$$name.txt --no-cache ; \
  	done


freeze:
	@venv/bin/pip -qq install pip-tools
	for name in prod dev ; do \
			venv/bin/pip-compile -qq $(REQUIREMENTS)/$$name.in -o $(REQUIREMENTS)/$$name.txt ; \
	done
	$(MAKE) install


lint:
	@venv/bin/isort src
	@venv/bin/black src
	@venv/bin/pylint src


up:
	docker-compose up --build
