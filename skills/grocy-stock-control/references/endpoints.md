# Endpoints

## Stock

- `GET /stock` - Returns all products which are currently in stock incl. the next due date per product
- `GET /stock/entry/{entryId}` - Returns details of the given stock
- `PUT /stock/entry/{entryId}` - Edits the stock entry
- `GET /stock/entry/{entryId}/printlabel` - Prints the Grocycode / stock entry label of the given entry on the configured label printer
- `GET /stock/volatile` - Returns all products which are due soon, overdue, expired or currently missing
- `GET /stock/products/{productId}` - Returns details of the given product
- `GET /stock/products/{productId}/locations` - Returns all locations where the given product currently has stock
- `GET /stock/products/{productId}/entries` - Returns all stock entries of the given product in order of next use (Opened first, then first due first, then first in first out)
- `GET /stock/products/{productId}/price-history` - Returns the price history of the given product
- `POST /stock/products/{productId}/add` - Adds the given amount of the given product to stock
- `POST /stock/products/{productId}/consume` - Removes the given amount of the given product from stock
- `POST /stock/products/{productId}/transfer` - Transfers the given amount of the given product from one location to another (this is currently not supported for tare weight handling enabled products)
- `POST /stock/products/{productId}/inventory` - Inventories the given product (adds/removes based on the given new amount)
- `POST /stock/products/{productId}/open` - Marks the given amount of the given product as opened
- `GET /stock/products/{productId}/printlabel` - Prints the Grocycode label of the given product on the configured label printer
- `POST /stock/products/{productIdToKeep}/merge/{productIdToRemove}` - Merges two products into one
- `GET /stock/locations/{locationId}/entries` - Returns all stock entries of the given location
- `POST /stock/shoppinglist/add-missing-products` - Adds currently missing products (below defined min. stock amount) to the given shopping list
- `POST /stock/shoppinglist/add-overdue-products` - Adds overdue products to the given shopping list
- `POST /stock/shoppinglist/add-expired-products` - Adds expired products to the given shopping list
- `POST /stock/shoppinglist/clear` - Removes all items from the given shopping list
- `POST /stock/shoppinglist/add-product` - Adds the given amount of the given product to the given shopping list
- `POST /stock/shoppinglist/remove-product` - Removes the given amount of the given product from the given shopping list, if it is on it
- `GET /stock/bookings/{bookingId}` - Returns the given stock booking
- `POST /stock/bookings/{bookingId}/undo` - Undoes a booking
- `GET /stock/transactions/{transactionId}` - Returns all stock bookings of the given transaction id
- `POST /stock/transactions/{transactionId}/undo` - Undoes a transaction
- `GET /stock/barcodes/external-lookup/{barcode}` - Executes an external barcode lookoup via the configured plugin with the given barcode

## Stock "by-barcode"

- `GET /stock/products/by-barcode/{barcode}` - Returns details of the given product by its barcode
- `POST /stock/products/by-barcode/{barcode}/add` - Adds the given amount of the by its barcode given product to stock
- `POST /stock/products/by-barcode/{barcode}/consume` - Removes the given amount of the by its barcode given product from stock
- `POST /stock/products/by-barcode/{barcode}/transfer` - Transfers the given amount of the by its barcode given product from one location to another (this is currently not supported for tare weight handling enabled products)
- `POST /stock/products/by-barcode/{barcode}/inventory` - Inventories the by its barcode given product (adds/removes based on the given new amount)
- `POST /stock/products/by-barcode/{barcode}/open` - Marks the given amount of the by its barcode given product as opened
