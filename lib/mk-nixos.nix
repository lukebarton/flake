{ inputs }:

{ hostname, system, users, extraModules }:

let
  userConfigs = map
    (user: [
      user.nixosModule
      {
        home-manager.users.${user.username} = {
          imports = [ user.homeModule ] ++ (user.extraHomeModules or [ ]);
        };
      }
    ])
    users;
in
inputs.nixpkgs.lib.nixosSystem {
  inherit system;
  specialArgs = { inherit inputs; };
  modules = [
    (../. + "/hosts/${hostname}")
    ../modules/nixos
    inputs.home-manager.nixosModules.home-manager
    {
      home-manager.useGlobalPkgs = true;
      home-manager.useUserPackages = true;
    }
  ] ++ (builtins.concatLists userConfigs) ++ extraModules;
}
