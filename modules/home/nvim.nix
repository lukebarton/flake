{ config, ... }: {
  imports = [ ./flake-path.nix ];

  home.file.".config/nvim".source = config.lib.file.mkOutOfStoreSymlink
    "${config.flakePath}/files/nvim";
}
