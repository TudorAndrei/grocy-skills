---
name: grocy-recipes
description: Work with Grocy recipe fulfillment and recipe actions, including all-recipes fulfillment, single-recipe fulfillment, adding not fulfilled products to the shopping list, consuming in-stock ingredients, copying recipes, and printing recipe labels. Use when the user wants to inspect recipe fulfillment, shop missing ingredients, consume a recipe, duplicate a recipe, or print a recipe label.
---

# Grocy Recipes

Use this skill for recipe fulfillment and recipe-driven shopping-list actions.

## Workflow

- Confirm `GROCY_BASE_URL` and `GROCY_API_KEY` are set before running any script.
- Pick the narrowest script that matches the user request.
- Prefer the built-in subcommands over ad hoc curl commands so auth, URLs, and response formatting stay consistent.
- Read `references/endpoints.md` when you need the exact route, response code, or parameter name.
- Return parsed JSON output unless the endpoint is binary or text based.

## Scripts

- `scripts/recipe-fulfillment.sh` - List fulfillment for all recipes or inspect one recipe fulfillment.
- `scripts/recipe-actions.sh` - Add missing products, consume recipe ingredients, copy recipes, or print recipe labels.

## Common Requests

- Show recipe fulfillment for everything or for one recipe.
- Add not fulfilled recipe ingredients to the shopping list.
- Consume all in-stock ingredients of a recipe.

## References

- Read `references/endpoints.md` for the exact recipe action routes.
