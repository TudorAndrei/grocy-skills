---
name: grocy-admin-and-entities
description: Administer Grocy system and entity endpoints, including system info, config, server time, localization strings, missing-localization logging, user management, user permissions, generic entity CRUD on exposed objects, and userfield reads or updates. Use when the user wants admin-level API access, to inspect system state, manage users or permissions, or work directly with exposed Grocy entities through /objects or /userfields.
---

# Grocy Admin And Entities

Use this skill for system-wide admin tasks and low-level exposed entity operations.

## Workflow

- Confirm `GROCY_BASE_URL` and `GROCY_API_KEY` are set before running any script.
- Pick the narrowest script that matches the user request.
- Prefer the built-in subcommands over ad hoc curl commands so auth, URLs, and response formatting stay consistent.
- Read `references/endpoints.md` when you need the exact route, response code, or parameter name.
- Return parsed JSON output unless the endpoint is binary or text based.

## Scripts

- `scripts/system-info.sh` - Fetch Grocy system metadata, config, time, localization strings, or log missing localization keys.
- `scripts/user-admin.sh` - List, create, update, delete users and manage permissions.
- `scripts/entity-crud.sh` - Run generic CRUD operations against exposed Grocy entities.
- `scripts/entity-userfields.sh` - Read or update userfields for exposed entities.
- `references/payloads.md` - Read for example request body shapes for admin and entity mutations.

## Common Requests

- List all users and inspect their assigned permissions.
- Update a user or replace their permissions.
- Read or write objects through the generic entity API.
- Inspect config or current server time from the Grocy instance.

## References

- Read `references/endpoints.md` for route coverage and `references/payloads.md` for sample mutation bodies.
