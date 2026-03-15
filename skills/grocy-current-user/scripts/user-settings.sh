#!/usr/bin/env bash
set -euo pipefail
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
# shellcheck source=/dev/null
. "$SCRIPT_DIR/_common.sh"

usage() {
  cat <<'EOF'
Usage:
  user-settings.sh list
  user-settings.sh get --setting-key KEY
  user-settings.sh set --setting-key KEY (--body JSON | --body-file FILE)
  user-settings.sh delete --setting-key KEY
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

setting_key=''
body=''
body_file=''

while [[ $# -gt 0 ]]; do
  case "$1" in
    --setting-key) setting_key="$2"; shift 2 ;;
    --body) body="$2"; shift 2 ;;
    --body-file) body_file="$2"; shift 2 ;;
    -h|--help) usage; exit 0 ;;
    *) usage_error "Unknown argument: $1" ;;
  esac
done

case "$command_name" in
  list)
    grocy_get_json '/user/settings'
    ;;
  get)
    require_value '--setting-key' "$setting_key"
    grocy_get_json "/user/settings/$setting_key"
    ;;
  set)
    require_value '--setting-key' "$setting_key"
    payload="$(read_json_body "$body" "$body_file")"
    grocy_send_json PUT "/user/settings/$setting_key" "$payload"
    ;;
  delete)
    require_value '--setting-key' "$setting_key"
    grocy_delete_json "/user/settings/$setting_key"
    ;;
  *)
    usage_error "Unknown subcommand: $command_name"
    ;;
esac
