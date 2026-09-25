{ config, lib, pkgs, ... }: {
  imports = [ ./flake-path.nix ];

  # On macOS Claude Code comes from the claude-code@latest Homebrew cask (self-updating).
  # On Linux run the native installer once; it puts a self-updating binary in ~/.local/bin
  # (already on PATH via uv.nix).
  home.activation.claudeCode = lib.mkIf pkgs.stdenv.isLinux (lib.hm.dag.entryAfter [ "writeBoundary" ] ''
    if [ ! -x "$HOME/.local/bin/claude" ]; then
      export PATH="${pkgs.curl}/bin:$PATH"
      run ${pkgs.bash}/bin/bash -c 'curl -fsSL https://claude.ai/install.sh | bash'
    fi
  '');

  # Personal global Claude Code instructions
  home.file.".claude/CLAUDE.md".source = config.lib.file.mkOutOfStoreSymlink
    "${config.flakePath}/files/claude/CLAUDE.personal.md";
}
