{ inputs }:

{ hostname, system, users, extraModules }:

let
  hostUserConfig = username:
    let path = ../. + "/hosts/${hostname}/users/${username}.nix";
    in if builtins.pathExists path then [ path ] else [ ];

  userConfigs = map
    (user: [
      user.darwinModule
      {
        home-manager.users.${user.username} = {
          imports = [ user.homeModule ] ++ (hostUserConfig user.username);
        };
      }
    ])
    users;
in
inputs.nix-darwin.lib.darwinSystem {
  inherit system;
  specialArgs = { inherit inputs; };
  modules = [
    (../. + "/hosts/${hostname}/darwin.nix")
    ../modules/darwin
    inputs.home-manager.darwinModules.home-manager
    {
      home-manager.useGlobalPkgs = true;
      home-manager.useUserPackages = true;
    }
  ] ++ (builtins.concatLists userConfigs) ++ extraModules;
}
