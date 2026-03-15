---
name: grocy-current-user
description: Inspect the authenticated Grocy user and manage current-user settings through /user and /user/settings endpoints. Use when the user wants to see their current Grocy profile, list personal settings, read one setting, change a current-user setting, or delete a setting without doing broader admin work.
---

# Grocy Current User

Use this skill for self-scoped user information and settings, not for admin user management.

## Workflow

- Confirm `GROCY_BASE_URL` and `GROCY_API_KEY` are set before running any script.
- Pick the narrowest script that matches the user request.
- Prefer the built-in subcommands over ad hoc curl commands so auth, URLs, and response formatting stay consistent.
- Read `references/endpoints.md` when you need the exact route, response code, or parameter name.
- Return parsed JSON output unless the endpoint is binary or text based.

## Scripts

- `scripts/current-user.sh` - Show the currently authenticated Grocy user.
- `scripts/user-settings.sh` - List, get, set, or delete current-user settings.
- `references/payloads.md` - Read for request body examples when writing settings.

## Common Requests

- Show who the current API key authenticates as.
- List all settings for the current user.
- Update one current-user setting by key.

## References

- Read `references/endpoints.md` for the exact settings routes and `references/payloads.md` before writing a setting.
