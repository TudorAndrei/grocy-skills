#!/usr/bin/env bash
set -euo pipefail
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
# shellcheck source=/dev/null
. "$SCRIPT_DIR/_common.sh"

usage() {
  cat <<'EOF'
Usage:
  stock-adjust.sh add --product-id ID (--body JSON | --body-file FILE)
  stock-adjust.sh consume --product-id ID (--body JSON | --body-file FILE)
  stock-adjust.sh add-barcode --barcode CODE (--body JSON | --body-file FILE)
  stock-adjust.sh consume-barcode --barcode CODE (--body JSON | --body-file FILE)
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
body=''
body_file=''

while [[ $# -gt 0 ]]; do
  case "$1" in
    --product-id) product_id="$2"; shift 2 ;;
    --barcode) barcode="$2"; shift 2 ;;
    --body) body="$2"; shift 2 ;;
    --body-file) body_file="$2"; shift 2 ;;
    -h|--help) usage; exit 0 ;;
    *) usage_error "Unknown argument: $1" ;;
  esac
done

payload="$(read_json_body "$body" "$body_file")"

case "$command_name" in
  add)
    require_value '--product-id' "$product_id"
    grocy_send_json POST "/stock/products/$product_id/add" "$payload"
    ;;
  consume)
    require_value '--product-id' "$product_id"
    grocy_send_json POST "/stock/products/$product_id/consume" "$payload"
    ;;
  add-barcode)
    require_value '--barcode' "$barcode"
    grocy_send_json POST "/stock/products/by-barcode/$barcode/add" "$payload"
    ;;
  consume-barcode)
    require_value '--barcode' "$barcode"
    grocy_send_json POST "/stock/products/by-barcode/$barcode/consume" "$payload"
    ;;
  *)
    usage_error "Unknown subcommand: $command_name"
    ;;
esac
