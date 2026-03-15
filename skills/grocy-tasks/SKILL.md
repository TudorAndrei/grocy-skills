---
name: grocy-tasks
description: Manage Grocy tasks, including listing incomplete tasks, completing a task, and undoing a task completion. Use when the user wants to inspect open tasks, mark a task done, or undo a mistaken completion.
---

# Grocy Tasks

Use this skill for the compact Grocy task workflow.

## Workflow

- Confirm `GROCY_BASE_URL` and `GROCY_API_KEY` are set before running any script.
- Pick the narrowest script that matches the user request.
- Prefer the built-in subcommands over ad hoc curl commands so auth, URLs, and response formatting stay consistent.
- Read `references/endpoints.md` when you need the exact route, response code, or parameter name.
- Return parsed JSON output unless the endpoint is binary or text based.

## Scripts

- `scripts/tasks.sh` - List incomplete tasks, complete tasks, or undo completions.

## Common Requests

- List all incomplete tasks.
- Complete one task or undo a mistaken completion.

## References

- Read `references/endpoints.md` for the task routes.
