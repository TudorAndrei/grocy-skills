#!/usr/bin/env bash
set -euo pipefail
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
# shellcheck source=/dev/null
. "$SCRIPT_DIR/_common.sh"

usage() {
  cat <<'EOF'
Usage:
  stock-history-undo.sh undo-booking --booking-id ID
  stock-history-undo.sh undo-transaction --transaction-id ID
  stock-history-undo.sh merge --product-id ID --remove-product-id ID
  stock-history-undo.sh add-missing-products
  stock-history-undo.sh add-overdue-products
  stock-history-undo.sh add-expired-products
  stock-history-undo.sh clear-shopping-list
  stock-history-undo.sh add-shopping-product (--body JSON | --body-file FILE)
  stock-history-undo.sh remove-shopping-product (--body JSON | --body-file FILE)
  stock-history-undo.sh print-label --product-id ID
  stock-history-undo.sh external-barcode-lookup --barcode CODE [--add true|false]
EOF
}

command_name="${1-}"
if [[ "$command_name" == '-h' || "$command_name" == '--help' ]]; then
  usage
  exit 0
fi
[[ -n "$command_name" ]] || { usage; exit 1; }
shift
init_grocy_tools

booking_id=''
transaction_id=''
product_id=''
remove_product_id=''
barcode=''
add_value=''
body=''
body_file=''

while [[ $# -gt 0 ]]; do
  case "$1" in
    --booking-id) booking_id="$2"; shift 2 ;;
    --transaction-id) transaction_id="$2"; shift 2 ;;
    --product-id) product_id="$2"; shift 2 ;;
    --remove-product-id) remove_product_id="$2"; shift 2 ;;
    --barcode) barcode="$2"; shift 2 ;;
    --add) add_value="$2"; shift 2 ;;
    --body) body="$2"; shift 2 ;;
    --body-file) body_file="$2"; shift 2 ;;
    -h|--help) usage; exit 0 ;;
    *) usage_error "Unknown argument: $1" ;;
  esac
done

case "$command_name" in
  undo-booking)
    require_value '--booking-id' "$booking_id"
    grocy_send_json POST "/stock/bookings/$booking_id/undo" '{}'
    ;;
  undo-transaction)
    require_value '--transaction-id' "$transaction_id"
    grocy_send_json POST "/stock/transactions/$transaction_id/undo" '{}'
    ;;
  merge)
    require_value '--product-id' "$product_id"
    require_value '--remove-product-id' "$remove_product_id"
    grocy_send_json POST "/stock/products/$product_id/merge/$remove_product_id" '{}'
    ;;
  add-missing-products)
    grocy_send_json POST '/stock/shoppinglist/add-missing-products' '{}'
    ;;
  add-overdue-products)
    grocy_send_json POST '/stock/shoppinglist/add-overdue-products' '{}'
    ;;
  add-expired-products)
    grocy_send_json POST '/stock/shoppinglist/add-expired-products' '{}'
    ;;
  clear-shopping-list)
    grocy_send_json POST '/stock/shoppinglist/clear' '{}'
    ;;
  add-shopping-product)
    payload="$(read_json_body "$body" "$body_file")"
    grocy_send_json POST '/stock/shoppinglist/add-product' "$payload"
    ;;
  remove-shopping-product)
    payload="$(read_json_body "$body" "$body_file")"
    grocy_send_json POST '/stock/shoppinglist/remove-product' "$payload"
    ;;
  print-label)
    require_value '--product-id' "$product_id"
    grocy_get_json "/stock/products/$product_id/printlabel"
    ;;
  external-barcode-lookup)
    require_value '--barcode' "$barcode"
    params=()
    [[ -n "$add_value" ]] && params+=("$(query_pair 'add' "$add_value")")
    grocy_get_json "/stock/barcodes/external-lookup/$barcode" "${params[@]}"
    ;;
  *)
    usage_error "Unknown subcommand: $command_name"
    ;;
esac
