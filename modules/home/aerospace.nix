{ config, ... }:
let
  homeDir = config.home.homeDirectory;
in {
  home.file.".config/aerospace/aerospace.toml".source = config.lib.file.mkOutOfStoreSymlink "${homeDir}/src/github.com/lukebarton/flake/files/aerospace/aerospace.toml";

  targets.darwin.defaults."bobko.aerospace" = {
    displayStyle = "squares";
  };

  # Sticky windows script
  home.file.".config/aerospace/sticky-windows.sh".source = ../../files/aerospace/sticky-windows.sh;
}
