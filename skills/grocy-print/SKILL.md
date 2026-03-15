---
name: grocy-print
description: Trigger Grocy print endpoints, currently the thermal shopping-list print route. Use when the user wants to print the shopping list with a configured thermal printer from Grocy.
---

# Grocy Print

Use this skill for the dedicated Grocy print endpoint.

## Workflow

- Confirm `GROCY_BASE_URL` and `GROCY_API_KEY` are set before running any script.
- Pick the narrowest script that matches the user request.
- Prefer the built-in subcommands over ad hoc curl commands so auth, URLs, and response formatting stay consistent.
- Read `references/endpoints.md` when you need the exact route, response code, or parameter name.
- Return parsed JSON output unless the endpoint is binary or text based.

## Scripts

- `scripts/print.sh` - Trigger the thermal shopping-list print route.

## Common Requests

- Print the shopping list with the configured thermal printer.

## References

- Read `references/endpoints.md` if you need the exact print route or response shape.
