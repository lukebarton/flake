{ inputs }:

{
  mkSystem = import ./mk-system.nix { inherit inputs; };

  forAllSystems = f:
    let
      systems = [ "aarch64-darwin" "x86_64-darwin" "x86_64-linux" "aarch64-linux" ];
    in
    builtins.listToAttrs (map (system: {
      name = system;
      value = f system;
    }) systems);

  exportModules = import ./export-modules.nix;

  merge = inputs.nixpkgs.lib.foldl' inputs.nixpkgs.lib.recursiveUpdate { };
}
