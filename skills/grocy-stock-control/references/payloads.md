# Stock Action Payloads

Use these payloads with `scripts/stock-adjust.sh`, `scripts/stock-transfer-open-inventory.sh`, and selected `scripts/stock-history-undo.sh` subcommands.

## Add stock

```json
{
  "amount": 1,
  "best_before_date": "2026-03-31",
  "transaction_type": "purchase",
  "price": 2.49,
  "location_id": 1
}
```

## Consume stock

```json
{
  "amount": 1,
  "spoiled": false,
  "stock_entry_id": 123
}
```

## Transfer stock

```json
{
  "amount": 1,
  "location_id_from": 1,
  "location_id_to": 2
}
```

## Inventory count

```json
{
  "new_amount": 3,
  "best_before_date": "2026-03-31",
  "price": 2.49
}
```

## Open product

```json
{
  "amount": 1,
  "stock_entry_id": 123
}
```

## Add product to shopping list

```json
{
  "product_id": 17,
  "amount": 2,
  "note": "Need this for breakfast"
}
```

## Remove product from shopping list

```json
{
  "product_id": 17,
  "amount": 1
}
```
