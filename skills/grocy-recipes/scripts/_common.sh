#!/usr/bin/env bash
set -euo pipefail

require_cmd() {
  command -v "$1" >/dev/null 2>&1 || {
    printf 'Missing required command: %s\n' "$1" >&2
    exit 1
  }
}

require_env() {
  : "${GROCY_BASE_URL:?Set GROCY_BASE_URL to your Grocy base URL or API URL}"
  : "${GROCY_API_KEY:?Set GROCY_API_KEY to a Grocy API key}"
}

init_grocy_tools() {
  require_cmd curl
  require_cmd jq
  require_cmd python3
  require_env
}

usage_error() {
  printf '%s\n' "$1" >&2
  exit 1
}

require_value() {
  local name="$1"
  local value="${2-}"
  [[ -n "$value" ]] || usage_error "Missing required value: $name"
}

grocy_api_base() {
  local base="${GROCY_BASE_URL%/}"
  if [[ "$base" == */api ]]; then
    printf '%s' "$base"
  else
    printf '%s/api' "$base"
  fi
}

urlencode() {
  python3 - "$1" <<'PY'
import sys
import urllib.parse

print(urllib.parse.quote(sys.argv[1], safe=''))
PY
}

query_pair() {
  local key="$1"
  local value="$2"
  printf '%s=%s' "$(urlencode "$key")" "$(urlencode "$value")"
}

build_url() {
  local path="$1"
  shift || true
  local url
  local sep='?'
  url="$(grocy_api_base)$path"
  for pair in "$@"; do
    [[ -n "$pair" ]] || continue
    url+="${sep}${pair}"
    sep='&'
  done
  printf '%s' "$url"
}

print_json_payload() {
  local payload="${1-}"
  [[ -n "$payload" ]] || return 0
  printf '%s\n' "$payload" | jq .
}

grocy_get_json() {
  local path="$1"
  shift || true
  local payload
  payload="$(curl --silent --show-error --fail-with-body \
    -H "GROCY-API-KEY: $GROCY_API_KEY" \
    -H 'Accept: application/json' \
    "$(build_url "$path" "$@")")"
  print_json_payload "$payload"
}

grocy_send_json() {
  local method="$1"
  local path="$2"
  local body="$3"
  shift 3 || true
  local payload
  payload="$(curl --silent --show-error --fail-with-body \
    -X "$method" \
    -H "GROCY-API-KEY: $GROCY_API_KEY" \
    -H 'Accept: application/json' \
    -H 'Content-Type: application/json' \
    --data "$body" \
    "$(build_url "$path" "$@")")"
  print_json_payload "$payload"
}

grocy_delete_json() {
  local path="$1"
  shift || true
  local payload
  payload="$(curl --silent --show-error --fail-with-body \
    -X DELETE \
    -H "GROCY-API-KEY: $GROCY_API_KEY" \
    -H 'Accept: application/json' \
    "$(build_url "$path" "$@")")"
  print_json_payload "$payload"
}

grocy_get_text() {
  local path="$1"
  shift || true
  curl --silent --show-error --fail-with-body \
    -H "GROCY-API-KEY: $GROCY_API_KEY" \
    -H 'Accept: text/calendar, text/plain;q=0.9, */*;q=0.8' \
    "$(build_url "$path" "$@")"
}

grocy_download_file() {
  local path="$1"
  local output="$2"
  shift 2 || true
  curl --silent --show-error --fail-with-body \
    -H "GROCY-API-KEY: $GROCY_API_KEY" \
    -o "$output" \
    "$(build_url "$path" "$@")"
}

grocy_upload_file() {
  local path="$1"
  local input_file="$2"
  shift 2 || true
  local payload
  payload="$(curl --silent --show-error --fail-with-body \
    -X PUT \
    -H "GROCY-API-KEY: $GROCY_API_KEY" \
    -H 'Accept: application/json' \
    -H 'Content-Type: application/octet-stream' \
    --data-binary "@$input_file" \
    "$(build_url "$path" "$@")")"
  print_json_payload "$payload"
}

base64_name() {
  python3 - "$1" <<'PY'
import base64
import sys

print(base64.b64encode(sys.argv[1].encode('utf-8')).decode('ascii'))
PY
}

read_json_body() {
  local inline="${1-}"
  local file_path="${2-}"
  local body
  if [[ -n "$inline" && -n "$file_path" ]]; then
    usage_error 'Use either --body or --body-file, not both'
  fi
  if [[ -n "$file_path" ]]; then
    [[ -f "$file_path" ]] || usage_error "Body file not found: $file_path"
    body="$(<"$file_path")"
  elif [[ -n "$inline" ]]; then
    body="$inline"
  else
    usage_error 'Provide --body or --body-file'
  fi
  printf '%s' "$body" | jq -e . >/dev/null
  printf '%s' "$body"
}
