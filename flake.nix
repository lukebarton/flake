{
  description = "Luke's nix configuration";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
    nix-darwin.url = "github:LnL7/nix-darwin";
    nix-darwin.inputs.nixpkgs.follows = "nixpkgs";
    home-manager.url = "github:nix-community/home-manager";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";
  };

  outputs = inputs@{ self, nix-darwin, nixpkgs, home-manager }:
    let
      lib = import ./lib { inherit inputs; };
    in
    lib.merge [
      # Darwin configurations
      {
        darwinConfigurations.mobius = lib.mkSystem {
          hostname = "mobius";
          system = "aarch64-darwin";
          users = [
            {
              username = "luke";
              darwinModule = ./users/luke/darwin.nix;
              homeModule = ./users/luke/home.nix;
            }
          ];
        };
      }

      # NixOS configurations (scaffold)
      # {
      #   nixosConfigurations.example = lib.mkSystem {
      #     hostname = "example";
      #     system = "x86_64-linux";
      #     users = [
      #       {
      #         username = "luke";
      #         nixosModule = ./users/luke/nixos.nix;
      #         homeModule = ./users/luke/home.nix;
      #       }
      #     ];
      #   };
      # }

      # Exported modules
      {
        darwinModules = lib.exportModules ./modules/darwin;
        nixosModules = lib.exportModules ./modules/nixos;
        homeManagerModules = lib.exportModules ./modules/home;
      }

      # Formatter
      {
        formatter = lib.forAllSystems (system:
          nixpkgs.legacyPackages.${system}.nixpkgs-fmt
        );
      }
    ];
}
