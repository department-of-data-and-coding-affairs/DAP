# The Data Analysis Platform

&copy; 2021 Nicholas H.Tollervey.

This is a simple, clean and open data analysis platform (DAP).

You are able to:

* curate data,
* provide tools for analysis, and,
* publish results.

That's it..!

More details will soon be available via the documentation.

## Developers

Python 3.8+. Django. Postgres in production, Sqlite for local development. The
[GDCSS](https://gdcss.netlify.app/) framework is used for presentation.

* Clone the repository.
* Create a new virtualenv
* `pip install -r requirements.txt` then `pip install -r requirements-dev.txt`.
* The `make` command is used for most common development tasks. E.g. `make run`
  or `make check`. Using `make` on its own tells you what's available.

```
$ make

There is no default Makefile target right now. Try:

make reset - reset migrate, loaddb, collect static and launch app.
make run - run the existing app.
make clean - reset the project and remove auto-generated assets.
make pyflakes - run the PyFlakes code checker.
make pycodestyle - run the PEP8 style checker.
make test - run the test suite.
make coverage - view a report on test coverage.
make tidy - tidy code with the 'black' formatter.
make check - run all the checkers and tests.
make dbreset - reset the migrations.
make migrate - make outstanding migrations and then migrate.
make collect - collect the static assets.
make dumpdb - dump the database to db.json.
make loaddb - load the database from db.json.
make docs - run sphinx to create project documentation.
```
