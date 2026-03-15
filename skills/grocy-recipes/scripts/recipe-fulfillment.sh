#!/usr/bin/env bash
set -euo pipefail
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
# shellcheck source=/dev/null
. "$SCRIPT_DIR/_common.sh"

usage() {
  cat <<'EOF'
Usage:
  recipe-fulfillment.sh all
  recipe-fulfillment.sh one --recipe-id ID
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

case "$command_name" in
  all) grocy_get_json '/recipes/fulfillment' ;;
  one)
    require_value '--recipe-id' "$recipe_id"
    grocy_get_json "/recipes/$recipe_id/fulfillment"
    ;;
  *) usage_error "Unknown subcommand: $command_name" ;;
esac
