{ config, ... }:
let
  homeDir = config.home.homeDirectory;
in
{
  # Personal global Claude Code instructions
  home.file.".claude/CLAUDE.md".source = config.lib.file.mkOutOfStoreSymlink
    "${homeDir}/src/github.com/lukebarton/flake/files/claude/CLAUDE.personal.md";
}
