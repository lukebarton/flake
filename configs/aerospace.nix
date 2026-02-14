{ config, ... }: {
  # Config
  #  home.file.".config/aerospace/aerospace.toml".source = ../files/aerospace/aerospace.toml;
  home.file.".config/aerospace/aerospace.toml".source = config.lib.file.mkOutOfStoreSymlink "/Users/luke/src/github.com/lukebarton/flake/files/aerospace/aerospace.toml";

  # Sticky windows script
  home.file.".config/aerospace/sticky-windows.sh".source = ../files/aerospace/sticky-windows.sh;
}
