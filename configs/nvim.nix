{ config, ... }: {
  home.file.".config/nvim".source = config.lib.file.mkOutOfStoreSymlink
    "/Users/luke/src/github.com/lukebarton/flake/files/nvim";
}
