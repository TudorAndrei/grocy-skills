---
name: grocy-files
description: Manage Grocy file endpoints, including binary upload, download, and deletion by file group and base64-encoded file name. Use when the user wants to fetch an attached file, upload a file into Grocy, or delete a file from a Grocy file group.
---

# Grocy Files

Use this skill for Grocy file transfer endpoints and binary payload handling.

## Workflow

- Confirm `GROCY_BASE_URL` and `GROCY_API_KEY` are set before running any script.
- Pick the narrowest script that matches the user request.
- Prefer the built-in subcommands over ad hoc curl commands so auth, URLs, and response formatting stay consistent.
- Read `references/endpoints.md` when you need the exact route, response code, or parameter name.
- Return parsed JSON output unless the endpoint is binary or text based.

## Scripts

- `scripts/files.sh` - Download, upload, or delete files in a Grocy file group.

## Common Requests

- Download a file from a file group.
- Upload a local file into Grocy.
- Delete a file by group and file name.

## References

- Read `references/endpoints.md` before working with files because the path uses a base64-encoded file name.
