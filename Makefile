XARGS := xargs -0 $(shell test $$(uname) = Linux && echo -r)
GREP_T_FLAG := $(shell test $$(uname) = Linux && echo -T)

all:
	@echo "\nThere is no default Makefile target right now. Try:\n"
	@echo "make reset - reset migrate, loaddb, collect static and launch app."
	@echo "make run - run the existing app."
	@echo "make clean - reset the project and remove auto-generated assets."
	@echo "make pyflakes - run the PyFlakes code checker."
	@echo "make pycodestyle - run the PEP8 style checker."
	@echo "make test - run the test suite."
	@echo "make coverage - view a report on test coverage."
	@echo "make tidy - tidy code with the 'black' formatter."
	@echo "make check - run all the checkers and tests."
	@echo "make dbreset - reset the migrations."
	@echo "make migrate - make outstanding migrations and then migrate."
	@echo "make collect - collect the static assets."
	@echo "make dumpdb - dump the database to db.json."
	@echo "make loaddb - load the database from db.json."
	@echo "make docs - run sphinx to create project documentation.\n"

clean:
	rm -rf staticfiles
	rm -rf build
	rm -rf dist
	rm -rf *.sqlite3
	rm -rf .coverage
	rm -rf .eggs
	rm -rf .pytest_cache
	rm -rf .tox
	rm -rf docs/_build
	find . \( -name '*.py[co]' -o -name dropin.cache \) -delete
	find . \( -name '*.bak' -o -name dropin.cache \) -delete
	find . \( -name '*.tgz' -o -name dropin.cache \) -delete
	find . | grep -E "(__pycache__)" | xargs rm -rf

dbreset:
	rm core/migrations/0*.py

migrate: clean
	./manage.py makemigrations
	./manage.py migrate

collect: clean
	./manage.py collectstatic --noinput

reset: clean migrate loaddb collect
	./manage.py runserver

run:
	./manage.py collectstatic --noinput
	./manage.py runserver

loaddb:
	./manage.py loaddata db.json

dumpdb:
	./manage.py dumpdata --indent 2 > db.json

pyflakes:
	find . \( -name _build -o -name var -o -path ./docs -o -name .env \) -type d -prune -o -name '*.py' -print0 | $(XARGS) pyflakes

pycodestyle:
	find . \( -name _build -o -name var -o -name .env \) -type d -prune -o -name '*.py' -print0 | $(XARGS) -n 1 pycodestyle --repeat --exclude=*/migrations/*,docs/*,.vscode/*,mediafiles/* --max-line-length=100 --ignore=E231,E731,E402,W504,W503

test: clean
	./manage.py test

coverage: clean
	coverage run --source='.' --omit=manage.py,dap/wsgi.py,dap/asgi.py,dap/urls.py,*/migrations/*,*/tests/*,*__init__.py manage.py test
	coverage report -m

tidy: clean
	@echo "\nTidying code with black..."
	black -l 79 core 
	black -l 79 dap 

check: clean tidy pycodestyle pyflakes coverage

docs: clean
	$(MAKE) -C docs html
	@echo "\nDocumentation can be found here:"
	@echo file://`pwd`/docs/_build/html/index.html
	@echo "\n"
