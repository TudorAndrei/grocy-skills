#!/usr/bin/env bash
set -euo pipefail
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
# shellcheck source=/dev/null
. "$SCRIPT_DIR/_common.sh"

usage() {
  cat <<'EOF'
Usage:
  recipe-actions.sh add-missing --recipe-id ID
  recipe-actions.sh consume --recipe-id ID
  recipe-actions.sh copy --recipe-id ID
  recipe-actions.sh print-label --recipe-id ID
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

recipe_id=''
while [[ $# -gt 0 ]]; do
  case "$1" in
    --recipe-id) recipe_id="$2"; shift 2 ;;
    -h|--help) usage; exit 0 ;;
    *) usage_error "Unknown argument: $1" ;;
  esac
done
require_value '--recipe-id' "$recipe_id"

case "$command_name" in
  add-missing)
    grocy_send_json POST "/recipes/$recipe_id/add-not-fulfilled-products-to-shoppinglist" '{}'
    ;;
  consume)
    grocy_send_json POST "/recipes/$recipe_id/consume" '{}'
    ;;
  copy)
    grocy_send_json POST "/recipes/$recipe_id/copy" '{}'
    ;;
  print-label)
    grocy_get_json "/recipes/$recipe_id/printlabel"
    ;;
  *)
    usage_error "Unknown subcommand: $command_name"
    ;;
esac
