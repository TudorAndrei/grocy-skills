#!/usr/bin/env bash
set -euo pipefail
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
# shellcheck source=/dev/null
. "$SCRIPT_DIR/_common.sh"

usage() {
  cat <<'EOF'
Usage:
  user-admin.sh list
  user-admin.sh get --user-id ID
  user-admin.sh create (--body JSON | --body-file FILE)
  user-admin.sh update --user-id ID (--body JSON | --body-file FILE)
  user-admin.sh delete --user-id ID
  user-admin.sh permissions-get --user-id ID
  user-admin.sh permissions-add --user-id ID (--body JSON | --body-file FILE)
  user-admin.sh permissions-set --user-id ID (--body JSON | --body-file FILE)
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

user_id=''
body=''
body_file=''

while [[ $# -gt 0 ]]; do
  case "$1" in
    --user-id) user_id="$2"; shift 2 ;;
    --body) body="$2"; shift 2 ;;
    --body-file) body_file="$2"; shift 2 ;;
    -h|--help) usage; exit 0 ;;
    *) usage_error "Unknown argument: $1" ;;
  esac
done

case "$command_name" in
  list)
    grocy_get_json '/users'
    ;;
  get)
    require_value '--user-id' "$user_id"
    grocy_get_json "/users/$user_id"
    ;;
  create)
    payload="$(read_json_body "$body" "$body_file")"
    grocy_send_json POST '/users' "$payload"
    ;;
  update)
    require_value '--user-id' "$user_id"
    payload="$(read_json_body "$body" "$body_file")"
    grocy_send_json PUT "/users/$user_id" "$payload"
    ;;
  delete)
    require_value '--user-id' "$user_id"
    grocy_delete_json "/users/$user_id"
    ;;
  permissions-get)
    require_value '--user-id' "$user_id"
    grocy_get_json "/users/$user_id/permissions"
    ;;
  permissions-add)
    require_value '--user-id' "$user_id"
    payload="$(read_json_body "$body" "$body_file")"
    grocy_send_json POST "/users/$user_id/permissions" "$payload"
    ;;
  permissions-set)
    require_value '--user-id' "$user_id"
    payload="$(read_json_body "$body" "$body_file")"
    grocy_send_json PUT "/users/$user_id/permissions" "$payload"
    ;;
  *)
    usage_error "Unknown subcommand: $command_name"
    ;;
esac
