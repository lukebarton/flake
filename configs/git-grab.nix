{ pkgs, ... }: {
  home.packages = [
    (pkgs.writeShellApplication {
      name = "git-grab";
      runtimeInputs = [ pkgs.git pkgs.coreutils ];
      text = ''
        usage() {
          echo "Usage: git-grab <repo-url> <path> <local-target>"
          echo "       git-grab <repo-url> <local-target>"
          echo ""
          echo "Download files from a git repo without .git metadata."
          echo ""
          echo "  repo-url      SSH or HTTPS URL, or owner/repo shorthand for GitHub"
          echo "  path          Path within the repo (use . for root)"
          echo "  local-target  Local destination directory"
          exit 1
        }

        if [[ $# -lt 2 || $# -gt 3 ]]; then
          usage
        fi

        REPO_URL="$1"
        # Expand owner/repo shorthand to GitHub SSH URL
        if [[ "$REPO_URL" != *://* && "$REPO_URL" != *@* && "$REPO_URL" =~ ^[^/]+/[^/]+$ ]]; then
          REPO_URL="git@github.com:$REPO_URL.git"
        fi

        if [[ $# -eq 2 ]]; then
          REPO_PATH="."
          LOCAL_TARGET="$2"
        else
          REPO_PATH="$2"
          LOCAL_TARGET="$3"
        fi

        # Resolve to absolute path
        LOCAL_TARGET="$(cd "$(dirname "$LOCAL_TARGET")" && pwd)/$(basename "$LOCAL_TARGET")"

        if [[ -e "$LOCAL_TARGET" ]]; then
          echo "Error: target already exists: $LOCAL_TARGET" >&2
          exit 1
        fi

        TMPDIR="$(mktemp -d)"
        trap 'rm -rf "$TMPDIR"' EXIT

        if [[ "$REPO_PATH" == "." ]]; then
          echo "Cloning..."
          git clone --depth=1 "$REPO_URL" "$TMPDIR/repo"
          rm -rf "$TMPDIR/repo/.git"
          cp -R "$TMPDIR/repo" "$LOCAL_TARGET"
        else
          echo "Cloning sparse checkout..."
          git clone --filter=blob:none --sparse --depth=1 --no-checkout "$REPO_URL" "$TMPDIR/repo"
          cd "$TMPDIR/repo"
          git sparse-checkout set "$REPO_PATH"
          git checkout

          if [[ ! -d "$REPO_PATH" ]]; then
            echo "Error: path not found in repo: $REPO_PATH" >&2
            exit 1
          fi

          cp -R "$REPO_PATH" "$LOCAL_TARGET"
        fi
        echo "Done: $LOCAL_TARGET"
      '';
    })
  ];
}
