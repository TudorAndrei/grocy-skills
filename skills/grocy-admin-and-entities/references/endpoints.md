# Endpoints

## System

- `GET /system/info` - Returns information about the installed Grocy version, PHP runtime and OS
- `GET /system/db-changed-time` - Returns the time when the database was last changed
- `GET /system/config` - Returns all config settings
- `GET /system/time` - Returns the current server time
- `GET /system/localization-strings` - Returns all localization strings (in the by the user desired language)
- `POST /system/log-missing-localization` - Logs a missing localization string

## User management

- `GET /users` - Returns all users
- `POST /users` - Creates a new user
- `PUT /users/{userId}` - Edits the given user
- `DELETE /users/{userId}` - Deletes the given user
- `GET /users/{userId}/permissions` - Returns the assigned permissions of the given user
- `POST /users/{userId}/permissions` - Adds a permission to the given user
- `PUT /users/{userId}/permissions` - Replaces the assigned permissions of the given user

## Generic entity interactions

- `GET /objects/{entity}` - Returns all objects of the given entity
- `POST /objects/{entity}` - Adds a single object of the given entity
- `GET /objects/{entity}/{objectId}` - Returns a single object of the given entity
- `PUT /objects/{entity}/{objectId}` - Edits the given object of the given entity
- `DELETE /objects/{entity}/{objectId}` - Deletes a single object of the given entity
- `GET /userfields/{entity}/{objectId}` - Returns all userfields with their values of the given object of the given entity
- `PUT /userfields/{entity}/{objectId}` - Edits the given userfields of the given object of the given entity
