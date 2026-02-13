#!/usr/bin/env bash
# Sticky windows: apps that follow you to every workspace.
# Some apps become invisible to `aerospace list-windows` but can still be
# moved with `move-node-to-workspace --window-id <id>`, so we track IDs proactively.
#
# Limitations: Only tracks a single window per entry.
# It grounds the list in the entries, to avoid creating an ever expanding list.
#
# Usage:
#   ./sticky-windows.sh              # scan and record window IDs
#   ./sticky-windows.sh <workspace>  # scan, then move sticky windows to workspace

STATE_FILE="/tmp/aerospace-sticky-windows"
TARGET="$1"

STICKY=(
  "antinote:app:^Antinote$"
  "calculator:app:^Calculator$"
)

# Seed with existing state so invisible windows aren't lost
prev=""
if [[ -f "$STATE_FILE" ]]; then
  prev=$(<"$STATE_FILE")
fi

# Scan windows for fresh matches
found_labels=""
found_lines=""

while IFS='|' read -r wid app title; do
  for entry in "${STICKY[@]}"; do
    IFS=':' read -r label type regex <<< "$entry"
    matched=0
    case "$type" in
      app)   [[ "$app"   =~ $regex ]] && matched=1 ;;
      title) [[ "$title" =~ $regex ]] && matched=1 ;;
    esac
    if [[ "$matched" -eq 1 ]]; then
      found_lines="${found_lines}${label}=${wid}"$'\n'
      found_labels="${found_labels} ${label} "
    fi
  done
done < <(aerospace list-windows --all --format '%{window-id}|%{app-name}|%{window-title}')

# Start with fresh matches
output="$found_lines"

# Preserve previous entries for labels not found in this scan
if [[ -n "$prev" ]]; then
  while IFS='=' read -r label wid; do
    [[ -z "$wid" ]] && continue
    [[ "$found_labels" == *" ${label} "* ]] && continue
    output="${output}${label}=${wid}"$'\n'
  done <<< "$prev"
fi

printf '%s' "$output" > "$STATE_FILE"

# If a workspace was given, move all sticky windows there
if [[ -n "$TARGET" && -f "$STATE_FILE" ]]; then
  while IFS='=' read -r label wid; do
    [[ -z "$wid" ]] && continue
    aerospace move-node-to-workspace --window-id "$wid" "$TARGET"
  done < "$STATE_FILE"
fi
