#!/usr/bin/env bash
set -euo pipefail
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
# shellcheck source=/dev/null
. "$SCRIPT_DIR/_common.sh"

usage() {
  cat <<'EOF'
Usage:
  stock-list.sh current [--query EXPR ...] [--order FIELD,DIRECTION] [--limit N] [--offset N]
  stock-list.sh volatile [--query EXPR ...] [--order FIELD,DIRECTION] [--limit N] [--offset N]
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

filters=()
order=''
limit=''
offset=''
while [[ $# -gt 0 ]]; do
  case "$1" in
    --query)
      filters+=("$2")
      shift 2
      ;;
    --order)
      order="$2"
      shift 2
      ;;
    --limit)
      limit="$2"
      shift 2
      ;;
    --offset)
      offset="$2"
      shift 2
      ;;
    -h|--help)
      usage
      exit 0
      ;;
    *)
      usage_error "Unknown argument: $1"
      ;;
  esac
done

case "$command_name" in
  current) path='/stock' ;;
  volatile) path='/stock/volatile' ;;
  *) usage_error "Unknown subcommand: $command_name" ;;
esac

params=()
for filter in "${filters[@]}"; do
  params+=("$(query_pair 'query[]' "$filter")")
done
[[ -n "$order" ]] && params+=("$(query_pair 'order' "$order")")
[[ -n "$limit" ]] && params+=("$(query_pair 'limit' "$limit")")
[[ -n "$offset" ]] && params+=("$(query_pair 'offset' "$offset")")

grocy_get_json "$path" "${params[@]}"
