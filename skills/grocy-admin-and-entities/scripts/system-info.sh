#!/usr/bin/env bash
set -euo pipefail
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
# shellcheck source=/dev/null
. "$SCRIPT_DIR/_common.sh"

usage() {
  cat <<'EOF'
Usage:
  system-info.sh info
  system-info.sh db-changed-time
  system-info.sh config
  system-info.sh time [--offset +02:00]
  system-info.sh localization-strings
  system-info.sh log-missing-localization (--body JSON | --body-file FILE)
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

offset=''
body=''
body_file=''

while [[ $# -gt 0 ]]; do
  case "$1" in
    --offset) offset="$2"; shift 2 ;;
    --body) body="$2"; shift 2 ;;
    --body-file) body_file="$2"; shift 2 ;;
    -h|--help) usage; exit 0 ;;
    *) usage_error "Unknown argument: $1" ;;
  esac
done

case "$command_name" in
  info) grocy_get_json '/system/info' ;;
  db-changed-time) grocy_get_json '/system/db-changed-time' ;;
  config) grocy_get_json '/system/config' ;;
  time)
    params=()
    [[ -n "$offset" ]] && params+=("$(query_pair 'offset' "$offset")")
    grocy_get_json '/system/time' "${params[@]}"
    ;;
  localization-strings) grocy_get_json '/system/localization-strings' ;;
  log-missing-localization)
    payload="$(read_json_body "$body" "$body_file")"
    grocy_send_json POST '/system/log-missing-localization' "$payload"
    ;;
  *) usage_error "Unknown subcommand: $command_name" ;;
esac
