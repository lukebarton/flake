{ config, ... }: {
  imports = [ ./flake-path.nix ];

  home.file.".config/aerospace/aerospace.toml".source = config.lib.file.mkOutOfStoreSymlink "${config.flakePath}/files/aerospace/aerospace.toml";

  targets.darwin.defaults."bobko.aerospace" = {
    displayStyle = "squares";
  };

  # Sticky windows script
  home.file.".config/aerospace/sticky-windows.sh".source = ../../files/aerospace/sticky-windows.sh;
}
