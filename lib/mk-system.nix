{ inputs }:

{ hostname, system, users ? [ ], extraModules ? [ ] }:

let
  isDarwin = builtins.match ".*-darwin" system != null;
  builder =
    if isDarwin
    then import ./mk-darwin.nix { inherit inputs; }
    else import ./mk-nixos.nix { inherit inputs; };
in
builder { inherit hostname system users extraModules; }
