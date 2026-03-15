#!/usr/bin/env bash
set -euo pipefail
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
# shellcheck source=/dev/null
. "$SCRIPT_DIR/_common.sh"

usage() {
  cat <<'EOF'
Usage:
  batteries.sh list
  batteries.sh get --battery-id ID
  batteries.sh charge --battery-id ID
  batteries.sh undo --charge-cycle-id ID
  batteries.sh print-label --battery-id ID
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

battery_id=''
charge_cycle_id=''
while [[ $# -gt 0 ]]; do
  case "$1" in
    --battery-id) battery_id="$2"; shift 2 ;;
    --charge-cycle-id) charge_cycle_id="$2"; shift 2 ;;
    -h|--help) usage; exit 0 ;;
    *) usage_error "Unknown argument: $1" ;;
  esac
done

case "$command_name" in
  list) grocy_get_json '/batteries' ;;
  get)
    require_value '--battery-id' "$battery_id"
    grocy_get_json "/batteries/$battery_id"
    ;;
  charge)
    require_value '--battery-id' "$battery_id"
    grocy_send_json POST "/batteries/$battery_id/charge" '{}'
    ;;
  undo)
    require_value '--charge-cycle-id' "$charge_cycle_id"
    grocy_send_json POST "/batteries/charge-cycles/$charge_cycle_id/undo" '{}'
    ;;
  print-label)
    require_value '--battery-id' "$battery_id"
    grocy_get_json "/batteries/$battery_id/printlabel"
    ;;
  *) usage_error "Unknown subcommand: $command_name" ;;
esac
