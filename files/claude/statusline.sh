# Claude Code statusline. Receives the session JSON on stdin.
# Wrapped by writeShellApplication in modules/home/claude.nix (adds shebang, set -euo pipefail, jq/git on PATH).

IFS=$'\t' read -r dir model < <(jq -r '[.workspace.current_dir, .model.display_name] | @tsv')

# The statusline payload carries no account identity, so read it from the config
# file the CLI writes at login. CLAUDE_CONFIG_DIR relocates that file, and each
# location holds a separately logged-in account.
config="${CLAUDE_CONFIG_DIR:-$HOME}/.claude.json"
[ -f "$config" ] || config="$HOME/.claude.json"

if [ -n "${ANTHROPIC_API_KEY:-}" ]; then
  account="api key"
else
  account=$(jq -r '.oauthAccount.emailAddress // "not logged in"' "$config" 2>/dev/null || true)
fi

branch=$(git -C "$dir" rev-parse --abbrev-ref HEAD 2>/dev/null || true)

printf '\033[2m%s\033[0m  %s%s  \033[2m%s\033[0m' \
  "${account:-not logged in}" "$(basename "$dir")" "${branch:+ ($branch)}" "$model"
