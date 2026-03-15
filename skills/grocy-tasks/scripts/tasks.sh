#!/usr/bin/env bash
set -euo pipefail
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
# shellcheck source=/dev/null
. "$SCRIPT_DIR/_common.sh"

usage() {
  cat <<'EOF'
Usage:
  tasks.sh list
  tasks.sh complete --task-id ID
  tasks.sh undo --task-id ID
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

task_id=''
while [[ $# -gt 0 ]]; do
  case "$1" in
    --task-id) task_id="$2"; shift 2 ;;
    -h|--help) usage; exit 0 ;;
    *) usage_error "Unknown argument: $1" ;;
  esac
done

case "$command_name" in
  list) grocy_get_json '/tasks' ;;
  complete)
    require_value '--task-id' "$task_id"
    grocy_send_json POST "/tasks/$task_id/complete" '{}'
    ;;
  undo)
    require_value '--task-id' "$task_id"
    grocy_send_json POST "/tasks/$task_id/undo" '{}'
    ;;
  *) usage_error "Unknown subcommand: $command_name" ;;
esac
