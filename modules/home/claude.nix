{ config, lib, pkgs, ... }: {
  imports = [ ./flake-path.nix ];

  # On macOS Claude Code comes from the claude-code@latest Homebrew cask (self-updating).
  # On Linux install the nixpkgs package; it tracks `make update` rather than auto-updating.
  home.packages = lib.optionals pkgs.stdenv.isLinux [ pkgs.claude-code ];

  # Personal global Claude Code instructions
  home.file.".claude/CLAUDE.md".source = config.lib.file.mkOutOfStoreSymlink
    "${config.flakePath}/files/claude/CLAUDE.personal.md";
}
