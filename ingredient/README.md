# @food-doods/ingredient

# Endpoints

## User

```
/ingredient/user/:userId
```

This endpoint is for adding and deleting users. Should be **called by user service only**.

### Methods

- **POST** &mdash; Adds blank ingredient fields for the given `userId`.
- **DELETE** &mdash; Remove all ingredient fields related to the given `userId`.

## Ingredient

```
/ingredient/:userId
```

For manipulation of ingredients related to `userId`.

Expects request to have body of shape:

```
{
  id: string,
  quantity: number,
  unit: string
}
```

Where:

* `id` &mdash; the id of the ingredient to be added
* `quantity` &mdash; quantity of the ingredient to be added
* `unit` &mdash; the unit that describes that quantity

### Methods

* **POST** &mdash; Adds an ingredient to `userId`'s pantry.
* **PUT** &mdash; Updates the `quantity` and/or `unit` fields of the ingredient.
* **DELETE** &mdash; Deletes the ingredient from the `userId`s pantry.

# Development

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
