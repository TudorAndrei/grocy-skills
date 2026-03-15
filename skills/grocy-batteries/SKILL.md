---
name: grocy-batteries
description: Manage Grocy batteries, including battery lists, battery details, charging batteries, undoing charge cycles, and printing battery labels. Use when the user wants to inspect batteries, record a charge, undo a charge cycle, or print a battery label.
---

# Grocy Batteries

Use this skill for battery tracking and charge-cycle actions.

## Workflow

- Confirm `GROCY_BASE_URL` and `GROCY_API_KEY` are set before running any script.
- Pick the narrowest script that matches the user request.
- Prefer the built-in subcommands over ad hoc curl commands so auth, URLs, and response formatting stay consistent.
- Read `references/endpoints.md` when you need the exact route, response code, or parameter name.
- Return parsed JSON output unless the endpoint is binary or text based.

## Scripts

- `scripts/batteries.sh` - List batteries, inspect one battery, charge a battery, undo a charge cycle, or print a label.

## Common Requests

- List batteries or show one battery.
- Record a battery charge or undo an accidental charge cycle.
- Print a battery label.

## References

- Read `references/endpoints.md` for the exact battery routes.
