---
name: grocy-chores
description: Manage Grocy chores, including chore lists, chore details, executing chores, undoing chore executions, recalculating next assignments, merging chores, and printing chore labels. Use when the user wants to inspect chores, mark a chore done, undo an execution, recalculate assignments, merge duplicate chores, or print a chore label.
---

# Grocy Chores

Use this skill for household chore tracking and chore execution flows.

## Workflow

- Confirm `GROCY_BASE_URL` and `GROCY_API_KEY` are set before running any script.
- Pick the narrowest script that matches the user request.
- Prefer the built-in subcommands over ad hoc curl commands so auth, URLs, and response formatting stay consistent.
- Read `references/endpoints.md` when you need the exact route, response code, or parameter name.
- Return parsed JSON output unless the endpoint is binary or text based.

## Scripts

- `scripts/chores.sh` - List chores, inspect one chore, execute or undo chores, recalculate assignments, merge chores, or print labels.

## Common Requests

- List chores or show one chore.
- Execute a chore or undo a mistaken execution.
- Merge duplicate chores or recalculate the next assignment.

## References

- Read `references/endpoints.md` for the exact chore routes and response codes.
