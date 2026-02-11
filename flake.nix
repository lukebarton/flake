{
  description = "Luke's nix-darwin configuration";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
    nix-darwin.url = "github:LnL7/nix-darwin";
    nix-darwin.inputs.nixpkgs.follows = "nixpkgs";
    home-manager.url = "github:nix-community/home-manager";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";
  };

  outputs = inputs@{ self, nix-darwin, nixpkgs, home-manager }:
    let
      darwinSystem = "aarch64-darwin";

      mkDarwinSystem = { hostname, extraHomeModules ? [ ] }:
        nix-darwin.lib.darwinSystem {
          system = darwinSystem;
          specialArgs = { inherit inputs; };
          modules = [
            ./hosts/${hostname}
            ./modules/darwin.nix
            home-manager.darwinModules.home-manager
            {
              home-manager.useGlobalPkgs = true;
              home-manager.useUserPackages = true;
              home-manager.users.luke = {
                imports = [ ./home/darwin.nix ] ++ extraHomeModules;
              };
            }
          ];
        };
    in
    {
      # Formatter for 'nix fmt'
      formatter.aarch64-darwin = nixpkgs.legacyPackages.aarch64-darwin.nixpkgs-fmt;

      darwinConfigurations = {
        mobius = mkDarwinSystem {
          hostname = "mobius";
          extraHomeModules = [ ./hosts/mobius/home.nix ];
        };
      };
    };
}
