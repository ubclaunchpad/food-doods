# @food-doods/ingredient

## Development

1. Install and start postgres:

```
brew install postgresql
brew services start postgres
```

2. Create user for postgres then login to postgres with that user (Note: this service assumes the user is "me" with password "password". This can be changed in `config/.env`):

```
postgres=# CREATE ROLE me WITH LOGIN PASSWORD 'password';
postgres=# ALTER ROLE me CREATEDB;
postgres=# \q
psql -d postgres -U me
```
3. Create database (default is "fooddoodsingredient"):

```
postgres=> CREATE DATABASE fooddoodsingredient;
postgres=> \c fooddoodsingrdient
```

4. Clone this repo, and run `yarn install`.
5. Start the server with `yarn start`.
