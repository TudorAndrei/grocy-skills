---
name: grocy-calendar
description: Access Grocy calendar endpoints, including downloading the iCal feed and fetching the public iCal sharing link. Use when the user wants calendar export data, the Grocy iCal feed, or the public sharing link for calendar subscriptions.
---

# Grocy Calendar

Use this skill for calendar export and calendar sharing-link access.

## Workflow

- Confirm `GROCY_BASE_URL` and `GROCY_API_KEY` are set before running any script.
- Pick the narrowest script that matches the user request.
- Prefer the built-in subcommands over ad hoc curl commands so auth, URLs, and response formatting stay consistent.
- Read `references/endpoints.md` when you need the exact route, response code, or parameter name.
- Return parsed JSON output unless the endpoint is binary or text based.

## Scripts

- `scripts/calendar.sh` - Download the iCal feed or fetch the public sharing link.

## Common Requests

- Download the Grocy calendar as an iCal file.
- Fetch the public calendar sharing link.

## References

- Read `references/endpoints.md` for content-type details and sharing-link behavior.
