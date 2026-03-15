#!/usr/bin/env bash
set -euo pipefail
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
# shellcheck source=/dev/null
. "$SCRIPT_DIR/_common.sh"

usage() {
  cat <<'EOF'
Usage:
  files.sh download --group NAME --file-name NAME --output PATH
  files.sh upload --group NAME --file-name NAME --input PATH
  files.sh delete --group NAME --file-name NAME
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

group_name=''
file_name=''
output=''
input=''
while [[ $# -gt 0 ]]; do
  case "$1" in
    --group) group_name="$2"; shift 2 ;;
    --file-name) file_name="$2"; shift 2 ;;
    --output) output="$2"; shift 2 ;;
    --input) input="$2"; shift 2 ;;
    -h|--help) usage; exit 0 ;;
    *) usage_error "Unknown argument: $1" ;;
  esac
done

require_value '--group' "$group_name"
require_value '--file-name' "$file_name"
encoded_name="$(base64_name "$file_name")"
path="/files/$group_name/$encoded_name"

case "$command_name" in
  download)
    require_value '--output' "$output"
    grocy_download_file "$path" "$output"
    ;;
  upload)
    require_value '--input' "$input"
    [[ -f "$input" ]] || usage_error "Input file not found: $input"
    grocy_upload_file "$path" "$input"
    ;;
  delete)
    grocy_delete_json "$path"
    ;;
  *) usage_error "Unknown subcommand: $command_name" ;;
esac
