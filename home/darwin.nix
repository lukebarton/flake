{ pkgs, ... }:

{
  imports = [
    ./home-manager.nix
  ];

  home.packages = import ../modules/common.nix { inherit pkgs; };
}
