# Flask Api

An API Built in Flask.

## Docker Quickstart

This app can be run completely using `Docker` and `docker-compose`. **Using Docker is recommended, as it guarantees the application is run using compatible versions of Python and Node**.

There are three main services:

To run the development version of the app

```bash
docker-compose up flask-dev
```

To run the production version of the app

```bash
docker-compose up flask-prod
```

The list of `environment:` variables in the `docker-compose.yml` file takes precedence over any variables specified in `.env`.

To run any commands using the `Flask CLI`

```bash
docker-compose run --rm manage <<COMMAND>>
```

Therefore, to initialize a database you would run

```bash
docker-compose run --rm manage db init
docker-compose run --rm manage db migrate
docker-compose run --rm manage db upgrade
```

### Running locally

Run the following commands to bootstrap your environment if you are unable to run the application using Docker

```bash
cd FlaskAPi
pip install poetry
poetry install
export FLASK_APP=autoapp
flask run
```

The flask API will start on `http://localhost:5000`.

#### Database Initialization (locally)

Once you have installed your DBMS, run the following to create your app's
database tables and perform the initial migration

```bash
flask db init
flask db migrate
flask db upgrade
```

## Deployment

When using Docker, reasonable production defaults are set in `docker-compose.yml`

```text
FLASK_ENV=production
FLASK_DEBUG=0
```

Therefore, starting the app in "production" mode is as simple as

```bash
docker-compose up flask-prod
```

If running without Docker

```bash
export FLASK_ENV=production
export FLASK_DEBUG=0
export DATABASE_URL="<YOUR DATABASE URL>"
npm run build   # build assets with webpack
flask run       # start the flask server
```

## Shell

To open the interactive shell, run

```bash
docker-compose run --rm manage db shell
flask shell # If running locally without Docker
```

By default, you will have access to the flask `app`.

## Running Tests/Linter

To run all tests, run

```bash
docker-compose run --rm manage test
flask test # If running locally without Docker
```

To run the linter, run

```bash
docker-compose run --rm manage lint
flask lint # If running locally without Docker
```

The `lint` command will attempt to fix any linting/style errors in the code. If you only want to know if the code will pass CI and do not wish for the linter to make changes, add the `--check` argument.

## Migrations

Whenever a database migration needs to be made. Run the following commands

```bash
docker-compose run --rm manage db migrate
flask db migrate # If running locally without Docker
```

This will generate a new migration script. Then run

```bash
docker-compose run --rm manage db upgrade
flask db upgrade # If running locally without Docker
```

To apply the migration.

For a full migration command reference, run `docker-compose run --rm manage db --help`.
