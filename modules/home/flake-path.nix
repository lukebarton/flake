{ config, lib, ... }: {
  options.flakePath = lib.mkOption {
    type = lib.types.str;
    default = "${config.home.homeDirectory}/src/github.com/lukebarton/flake";
    description = "Absolute path to this flake's working copy, used for out-of-store symlinks.";
  };
}
