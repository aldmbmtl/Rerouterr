REQUIREMENTS := requirements
SHELL := /bin/bash

clean:
	@rm -rf venv

install: clean
	@virtualenv venv
	for name in prod test dev ; do \
  		venv/bin/pip install -r $(REQUIREMENTS)/$$name.txt --no-cache ; \
  	done


freeze:
	@venv/bin/pip install pip-tools
	for name in prod test dev ; do \
			venv/bin/pip-compile $(REQUIREMENTS)/$$name.in -o $(REQUIREMENTS)/$$name.txt ; \
	done
	$(MAKE) install


lint:
	@venv/bin/isort skiff
	@venv/bin/black skiff
	@venv/bin/pylint skiff
