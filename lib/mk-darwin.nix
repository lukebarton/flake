{ inputs }:

{ hostname, system, users, extraModules }:

let
  userConfigs = map
    (user: [
      user.darwinModule
      {
        home-manager.users.${user.username} = {
          imports = [ user.homeModule ] ++ (user.extraHomeModules or [ ]);
        };
      }
    ])
    users;
in
inputs.nix-darwin.lib.darwinSystem {
  inherit system;
  specialArgs = { inherit inputs; };
  modules = [
    (../. + "/hosts/${hostname}")
    ../modules/darwin
    inputs.home-manager.darwinModules.home-manager
    {
      home-manager.useGlobalPkgs = true;
      home-manager.useUserPackages = true;
    }
  ] ++ (builtins.concatLists userConfigs) ++ extraModules;
}
