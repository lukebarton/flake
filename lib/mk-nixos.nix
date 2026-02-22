{ inputs }:

{ hostname, system, users, extraModules }:

let
  hostUserConfig = username:
    let path = ../. + "/hosts/${hostname}/users/${username}.nix";
    in if builtins.pathExists path then [ path ] else [ ];

  userConfigs = map
    (user: [
      user.nixosModule
      {
        home-manager.users.${user.username} = {
          imports = [ user.homeModule ] ++ (hostUserConfig user.username);
        };
      }
    ])
    users;
in
inputs.nixpkgs.lib.nixosSystem {
  inherit system;
  specialArgs = { inherit inputs; };
  modules = [
    (../. + "/hosts/${hostname}/nixos.nix")
    ../modules/nixos
    inputs.home-manager.nixosModules.home-manager
    {
      home-manager.useGlobalPkgs = true;
      home-manager.useUserPackages = true;
    }
  ] ++ (builtins.concatLists userConfigs) ++ extraModules;
}
