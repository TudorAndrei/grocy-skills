#!/usr/bin/env bash
set -euo pipefail
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
# shellcheck source=/dev/null
. "$SCRIPT_DIR/_common.sh"

usage() {
  cat <<'EOF'
Usage:
  chores.sh list
  chores.sh get --chore-id ID
  chores.sh execute --chore-id ID
  chores.sh undo --execution-id ID
  chores.sh recalculate --chore-id ID
  chores.sh merge --chore-id ID --remove-chore-id ID
  chores.sh print-label --chore-id ID
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

chore_id=''
execution_id=''
remove_chore_id=''
while [[ $# -gt 0 ]]; do
  case "$1" in
    --chore-id) chore_id="$2"; shift 2 ;;
    --execution-id) execution_id="$2"; shift 2 ;;
    --remove-chore-id) remove_chore_id="$2"; shift 2 ;;
    -h|--help) usage; exit 0 ;;
    *) usage_error "Unknown argument: $1" ;;
  esac
done

case "$command_name" in
  list) grocy_get_json '/chores' ;;
  get)
    require_value '--chore-id' "$chore_id"
    grocy_get_json "/chores/$chore_id"
    ;;
  execute)
    require_value '--chore-id' "$chore_id"
    grocy_send_json POST "/chores/$chore_id/execute" '{}'
    ;;
  undo)
    require_value '--execution-id' "$execution_id"
    grocy_send_json POST "/chores/executions/$execution_id/undo" '{}'
    ;;
  recalculate)
    require_value '--chore-id' "$chore_id"
    grocy_send_json POST "/chores/$chore_id/calculate-next-assignment" '{}'
    ;;
  merge)
    require_value '--chore-id' "$chore_id"
    require_value '--remove-chore-id' "$remove_chore_id"
    grocy_send_json POST "/chores/$chore_id/merge/$remove_chore_id" '{}'
    ;;
  print-label)
    require_value '--chore-id' "$chore_id"
    grocy_get_json "/chores/$chore_id/printlabel"
    ;;
  *) usage_error "Unknown subcommand: $command_name" ;;
esac
