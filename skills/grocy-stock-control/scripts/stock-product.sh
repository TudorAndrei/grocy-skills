#!/usr/bin/env bash
set -euo pipefail
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
# shellcheck source=/dev/null
. "$SCRIPT_DIR/_common.sh"

usage() {
  cat <<'EOF'
Usage:
  stock-product.sh show --product-id ID
  stock-product.sh show-barcode --barcode CODE
  stock-product.sh locations --product-id ID
  stock-product.sh entries --product-id ID
  stock-product.sh price-history --product-id ID
  stock-product.sh entry --stock-id ID
  stock-product.sh booking --booking-id ID
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

product_id=''
barcode=''
stock_id=''
booking_id=''

while [[ $# -gt 0 ]]; do
  case "$1" in
    --product-id) product_id="$2"; shift 2 ;;
    --barcode) barcode="$2"; shift 2 ;;
    --stock-id) stock_id="$2"; shift 2 ;;
    --booking-id) booking_id="$2"; shift 2 ;;
    -h|--help) usage; exit 0 ;;
    *) usage_error "Unknown argument: $1" ;;
  esac
done

case "$command_name" in
  show)
    require_value '--product-id' "$product_id"
    grocy_get_json "/stock/products/$product_id"
    ;;
  show-barcode)
    require_value '--barcode' "$barcode"
    grocy_get_json "/stock/products/by-barcode/$barcode"
    ;;
  locations)
    require_value '--product-id' "$product_id"
    grocy_get_json "/stock/products/$product_id/locations"
    ;;
  entries)
    require_value '--product-id' "$product_id"
    grocy_get_json "/stock/products/$product_id/entries"
    ;;
  price-history)
    require_value '--product-id' "$product_id"
    grocy_get_json "/stock/products/$product_id/price-history"
    ;;
  entry)
    require_value '--stock-id' "$stock_id"
    grocy_get_json "/stock/$stock_id"
    ;;
  booking)
    require_value '--booking-id' "$booking_id"
    grocy_get_json "/stock/bookings/$booking_id"
    ;;
  *)
    usage_error "Unknown subcommand: $command_name"
    ;;
esac
