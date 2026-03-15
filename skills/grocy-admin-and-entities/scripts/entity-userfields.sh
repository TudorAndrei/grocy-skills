#!/usr/bin/env bash
set -euo pipefail
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
# shellcheck source=/dev/null
. "$SCRIPT_DIR/_common.sh"

usage() {
  cat <<'EOF'
Usage:
  entity-userfields.sh get --entity NAME --object-id ID
  entity-userfields.sh set --entity NAME --object-id ID (--body JSON | --body-file FILE)
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

entity=''
object_id=''
body=''
body_file=''

while [[ $# -gt 0 ]]; do
  case "$1" in
    --entity) entity="$2"; shift 2 ;;
    --object-id) object_id="$2"; shift 2 ;;
    --body) body="$2"; shift 2 ;;
    --body-file) body_file="$2"; shift 2 ;;
    -h|--help) usage; exit 0 ;;
    *) usage_error "Unknown argument: $1" ;;
  esac
done

require_value '--entity' "$entity"
require_value '--object-id' "$object_id"

case "$command_name" in
  get)
    grocy_get_json "/userfields/$entity/$object_id"
    ;;
  set)
    payload="$(read_json_body "$body" "$body_file")"
    grocy_send_json PUT "/userfields/$entity/$object_id" "$payload"
    ;;
  *) usage_error "Unknown subcommand: $command_name" ;;
esac
