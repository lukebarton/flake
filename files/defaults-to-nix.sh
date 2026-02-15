#!/usr/bin/env bash
# defaults-to-nix: interactively browse macOS defaults domains,
# select keys, and copy Nix-formatted output to clipboard.

# Convert a JSON value to Nix syntax, indented at the given depth
json_to_nix() {
  local json="$1"
  local indent="$2"
  local pad=""
  local inner_pad=""
  for ((i = 0; i < indent; i++)); do pad+="  "; done
  for ((i = 0; i < indent + 1; i++)); do inner_pad+="  "; done

  local jtype
  jtype="$(echo "$json" | jq -r 'type')"

  case "$jtype" in
    string)
      echo "$json" | jq -r '@json'
      ;;
    number)
      echo "$json" | jq -r '.'
      ;;
    boolean)
      echo "$json" | jq -r 'if . then "true" else "false" end'
      ;;
    null)
      echo "null"
      ;;
    array)
      local len
      len="$(echo "$json" | jq 'length')"
      if [[ "$len" -eq 0 ]]; then
        echo "[ ]"
      else
        echo "["
        for ((idx = 0; idx < len; idx++)); do
          local elem
          elem="$(echo "$json" | jq ".[$idx]")"
          local elem_nix
          elem_nix="$(json_to_nix "$elem" $((indent + 1)))"
          echo "$inner_pad$elem_nix"
        done
        echo "$pad]"
      fi
      ;;
    object)
      local keys_len
      keys_len="$(echo "$json" | jq 'keys | length')"
      if [[ "$keys_len" -eq 0 ]]; then
        echo "{ }"
      else
        echo "{"
        local obj_keys
        obj_keys="$(echo "$json" | jq -r 'keys[]')"
        while IFS= read -r obj_key; do
          local obj_val
          obj_val="$(echo "$json" | jq --arg k "$obj_key" '.[$k]')"
          local obj_val_type
          obj_val_type="$(echo "$obj_val" | jq -r 'type')"
          if [[ "$obj_val_type" == "string" ]]; then
            # Check for binary/data (base64-encoded blobs from plutil)
            local str_val
            str_val="$(echo "$obj_val" | jq -r '.')"
            if [[ ${#str_val} -gt 200 ]] && echo "$str_val" | grep -qE '^[A-Za-z0-9+/=]+$'; then
              echo "$inner_pad# $obj_key = <binary data, skipped>" >&2
              continue
            fi
          fi
          local nix_key="$obj_key"
          # Quote keys that aren't simple identifiers
          if ! [[ "$obj_key" =~ ^[a-zA-Z_][a-zA-Z0-9_-]*$ ]]; then
            nix_key="\"$obj_key\""
          fi
          local val_nix
          val_nix="$(json_to_nix "$obj_val" $((indent + 1)))"
          echo "$inner_pad$nix_key = $val_nix;"
        done <<< "$obj_keys"
        echo "$pad}"
      fi
      ;;
    *)
      echo "\"<unsupported: $jtype>\""
      ;;
  esac
}

# Step 1: Get domains and let user pick one
DOMAINS="$(defaults domains | tr ',' '\n' | sed 's/^ *//;s/ *$//')"
DOMAIN="$(echo "$DOMAINS" | gum filter --placeholder "Search domains...")"

if [[ -z "$DOMAIN" ]]; then
  echo "No domain selected." >&2
  exit 1
fi

echo "Selected domain: $DOMAIN" >&2

# Step 2: Export domain to plist, then convert to JSON (using python3
# because plutil -convert json chokes on binary <data> entries)
JSON="$(defaults export "$DOMAIN" - | python3 -c "
import sys, plistlib, json
def convert(obj):
    if isinstance(obj, bytes):
        return None
    if isinstance(obj, dict):
        return {k: v2 for k, v in obj.items() if (v2 := convert(v)) is not None}
    if isinstance(obj, list):
        return [v2 for v in obj if (v2 := convert(v)) is not None]
    if isinstance(obj, (int, float, bool, str)):
        return obj
    return str(obj)
plist = plistlib.loads(sys.stdin.buffer.read())
print(json.dumps(convert(plist)))
")" || {
  echo "Failed to export domain: $DOMAIN" >&2
  exit 1
}

# Step 3: Build key list with type/value previews
KEYS="$(echo "$JSON" | jq -r 'to_entries[] | "\(.key)\t\(.value | type)\t\(if (.value | type) == "string" then .value[:80] elif (.value | type) == "array" then "[\(.value | length) items]" elif (.value | type) == "object" then "{\(.value | keys | length) keys}" else (.value | tostring) end)"')"

if [[ -z "$KEYS" ]]; then
  echo "No keys found in domain: $DOMAIN" >&2
  exit 1
fi

# Format for display: "key (type: preview)"
DISPLAY_KEYS="$(echo "$KEYS" | while IFS=$'\t' read -r key type preview; do
  echo "$key  ($type: $preview)"
done)"

SELECTED="$(echo "$DISPLAY_KEYS" | gum filter --no-limit --header "Select keys from $DOMAIN")"

if [[ -z "$SELECTED" ]]; then
  echo "No keys selected." >&2
  exit 1
fi

# Step 4: Extract just the key names from selections
SELECTED_KEYS=""
while IFS= read -r line; do
  SELECTED_KEYS+="${line%%  (*}"$'\n'
done <<< "$SELECTED"
SELECTED_KEYS="${SELECTED_KEYS%$'\n'}"

# Step 5: Build the Nix output
OUTPUT="targets.darwin.defaults.\"$DOMAIN\" = {"
while IFS= read -r key; do
  VAL="$(echo "$JSON" | jq --arg k "$key" '.[$k]')"
  VAL_TYPE="$(echo "$VAL" | jq -r 'type')"

  # Skip binary data
  if [[ "$VAL_TYPE" == "string" ]]; then
    STR_VAL="$(echo "$VAL" | jq -r '.')"
    if [[ ${#STR_VAL} -gt 200 ]] && echo "$STR_VAL" | grep -qE '^[A-Za-z0-9+/=]+$'; then
      echo "Skipping binary key: $key" >&2
      continue
    fi
  fi

  NIX_VAL="$(json_to_nix "$VAL" 1)"

  # Quote keys that aren't simple identifiers
  NIX_KEY="$key"
  if ! [[ "$key" =~ ^[a-zA-Z_][a-zA-Z0-9_-]*$ ]]; then
    NIX_KEY="\"$key\""
  fi

  OUTPUT+=$'\n'"  $NIX_KEY = $NIX_VAL;"
done <<< "$SELECTED_KEYS"
OUTPUT+=$'\n};'

# Step 6: Copy to clipboard and print
echo "$OUTPUT" | pbcopy
echo "" >&2
gum style --border rounded --padding "0 1" --border-foreground 212 "$OUTPUT"
echo "" >&2
echo "Copied to clipboard!" >&2
