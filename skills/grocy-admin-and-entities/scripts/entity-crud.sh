#!/usr/bin/env bash
set -euo pipefail
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
# shellcheck source=/dev/null
. "$SCRIPT_DIR/_common.sh"

usage() {
  cat <<'EOF'
Usage:
  entity-crud.sh list --entity NAME [--query EXPR ...] [--order FIELD,DIRECTION] [--limit N] [--offset N]
  entity-crud.sh get --entity NAME --object-id ID
  entity-crud.sh create --entity NAME (--body JSON | --body-file FILE)
  entity-crud.sh update --entity NAME --object-id ID (--body JSON | --body-file FILE)
  entity-crud.sh delete --entity NAME --object-id ID
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
filters=()
order=''
limit=''
offset=''

while [[ $# -gt 0 ]]; do
  case "$1" in
    --entity) entity="$2"; shift 2 ;;
    --object-id) object_id="$2"; shift 2 ;;
    --body) body="$2"; shift 2 ;;
    --body-file) body_file="$2"; shift 2 ;;
    --query) filters+=("$2"); shift 2 ;;
    --order) order="$2"; shift 2 ;;
    --limit) limit="$2"; shift 2 ;;
    --offset) offset="$2"; shift 2 ;;
    -h|--help) usage; exit 0 ;;
    *) usage_error "Unknown argument: $1" ;;
  esac
done

require_value '--entity' "$entity"
case "$command_name" in
  list)
    params=()
    for filter in "${filters[@]}"; do
      params+=("$(query_pair 'query[]' "$filter")")
    done
    [[ -n "$order" ]] && params+=("$(query_pair 'order' "$order")")
    [[ -n "$limit" ]] && params+=("$(query_pair 'limit' "$limit")")
    [[ -n "$offset" ]] && params+=("$(query_pair 'offset' "$offset")")
    grocy_get_json "/objects/$entity" "${params[@]}"
    ;;
  get)
    require_value '--object-id' "$object_id"
    grocy_get_json "/objects/$entity/$object_id"
    ;;
  create)
    payload="$(read_json_body "$body" "$body_file")"
    grocy_send_json POST "/objects/$entity" "$payload"
    ;;
  update)
    require_value '--object-id' "$object_id"
    payload="$(read_json_body "$body" "$body_file")"
    grocy_send_json PUT "/objects/$entity/$object_id" "$payload"
    ;;
  delete)
    require_value '--object-id' "$object_id"
    grocy_delete_json "/objects/$entity/$object_id"
    ;;
  *)
    usage_error "Unknown subcommand: $command_name"
    ;;
esac
