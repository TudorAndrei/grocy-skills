---
name: grocy-stock-control
description: Inspect and change Grocy stock by product id or barcode, including current stock queries, product details, stock entries, add or consume actions, transfer, inventory, opening products, undoing bookings or transactions, shopping-list helpers, label printing, and external barcode lookup. Use when the user wants to check stock, change inventory, reconcile counts, move products between locations, open items, undo stock activity, print stock labels, or work from a barcode.
---

# Grocy Stock Control

Use this skill for stock-related Grocy work, including barcode-driven variants of the stock endpoints.

## Workflow

- Confirm `GROCY_BASE_URL` and `GROCY_API_KEY` are set before running any script.
- Pick the narrowest script that matches the user request.
- Prefer the built-in subcommands over ad hoc curl commands so auth, URLs, and response formatting stay consistent.
- Read `references/endpoints.md` when you need the exact route, response code, or parameter name.
- Return parsed JSON output unless the endpoint is binary or text based.

## Scripts

- `scripts/stock-list.sh` - List current or volatile stock with optional query filters.
- `scripts/stock-product.sh` - Inspect products, stock entries, locations, and price history.
- `scripts/stock-adjust.sh` - Add to or consume stock by product id or barcode.
- `scripts/stock-transfer-open-inventory.sh` - Transfer, open, or inventory products by id or barcode.
- `scripts/stock-history-undo.sh` - Inspect bookings, undo history, manage shopping-list helpers, print labels, and run external barcode lookup.
- `references/payloads.md` - Read for request body shapes used by stock action scripts.

## Common Requests

- Check current stock for all products due soon.
- Consume one milk by barcode and show the resulting stock log entries.
- Transfer a product from pantry to fridge.
- Undo a mistaken stock booking or transaction.

## References

- Read `references/endpoints.md` for the exact stock routes and `references/payloads.md` before sending action bodies.
