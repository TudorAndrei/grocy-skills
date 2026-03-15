#!/usr/bin/env bash
set -euo pipefail
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
# shellcheck source=/dev/null
. "$SCRIPT_DIR/_common.sh"

usage() {
  cat <<'EOF'
Usage:
  calendar.sh ical [--output FILE]
  calendar.sh sharing-link
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

output=''
while [[ $# -gt 0 ]]; do
  case "$1" in
    --output) output="$2"; shift 2 ;;
    -h|--help) usage; exit 0 ;;
    *) usage_error "Unknown argument: $1" ;;
  esac
done

case "$command_name" in
  ical)
    if [[ -n "$output" ]]; then
      grocy_download_file '/calendar/ical' "$output"
    else
      grocy_get_text '/calendar/ical'
    fi
    ;;
  sharing-link)
    grocy_get_json '/calendar/ical/sharing-link'
    ;;
  *) usage_error "Unknown subcommand: $command_name" ;;
esac
