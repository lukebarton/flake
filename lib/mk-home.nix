{ inputs }:

# Standalone home-manager configuration for a non-NixOS Linux host (e.g. Ubuntu).
{ hostname, system, username, homeModule, extraModules ? [ ] }:

let
  hostUserConfig =
    let path = ../. + "/hosts/${hostname}/users/${username}.nix";
    in if builtins.pathExists path then [ path ] else [ ];
in
inputs.home-manager.lib.homeManagerConfiguration {
  pkgs = import inputs.nixpkgs {
    inherit system;
    config.allowUnfree = true;
  };
  extraSpecialArgs = { inherit inputs; };
  modules = [
    (../. + "/hosts/${hostname}/home.nix")
    {
      # Nix profile paths, XDG dirs and locale fixes for non-NixOS Linux
      targets.genericLinux.enable = true;
      # Puts the `home-manager` CLI on PATH after the first activation
      programs.home-manager.enable = true;
    }
    homeModule
  ] ++ hostUserConfig ++ extraModules;
}
