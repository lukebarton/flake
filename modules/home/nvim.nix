{ config, ... }:
let
  homeDir = config.home.homeDirectory;
in {
  home.file.".config/nvim".source = config.lib.file.mkOutOfStoreSymlink
    "${homeDir}/src/github.com/lukebarton/flake/files/nvim";
}
