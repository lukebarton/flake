{ config, ... }: {
  imports = [ ./flake-path.nix ];

  # Personal global Claude Code instructions
  home.file.".claude/CLAUDE.md".source = config.lib.file.mkOutOfStoreSymlink
    "${config.flakePath}/files/claude/CLAUDE.personal.md";
}
