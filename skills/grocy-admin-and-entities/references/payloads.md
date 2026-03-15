# Admin And Entity Payloads

## Create or update user

```json
{
  "username": "api-user",
  "first_name": "API",
  "last_name": "User",
  "password": "change-me",
  "row_created_timestamp": "2026-03-15 12:00:00"
}
```

## Replace or add permissions

```json
{
  "permissions": [1, 2, 3]
}
```

## Generic entity create or update

```json
{
  "name": "Example value"
}
```

## Set userfields

```json
{
  "custom_field": "custom value"
}
```

## Log missing localization

```json
{
  "text": "new_key",
  "language": "en"
}
```
