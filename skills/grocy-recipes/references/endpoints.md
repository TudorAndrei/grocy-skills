# Endpoints

## Recipes

- `POST /recipes/{recipeId}/add-not-fulfilled-products-to-shoppinglist` - Adds all missing products for the given recipe to the shopping list
- `GET /recipes/{recipeId}/fulfillment` - Get stock fulfillment information for the given recipe
- `POST /recipes/{recipeId}/consume` - Consumes all in stock ingredients of the given recipe (for ingredients that are only partially in stock, the in stock amount will be consumed)
- `GET /recipes/fulfillment` - Get stock fulfillment information for all recipe
- `POST /recipes/{recipeId}/copy` - Copies a recipe
- `GET /recipes/{recipeId}/printlabel` - Prints the Grocycode label of the given recipe on the configured label printer
