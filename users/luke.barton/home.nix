{ pkgs, ... }: {
  imports = [
    ../../modules/home/shell.nix
    ../../modules/home/colima.nix
    ../../modules/home/programs.nix
    ../../modules/home/1password.nix
    ../../modules/home/aerospace.nix
    ../../modules/home/git.nix
    ../../modules/home/custom-scripts.nix
    ../../modules/home/ghostty.nix
    ../../modules/home/leaderkey.nix
    ../../modules/home/linearmouse.nix
    ../../modules/home/misc-app-defaults.nix
    ../../modules/home/nvim.nix
    ../../modules/home/pnpm.nix
    ../../modules/home/rclone.nix
    ../../modules/home/starship.nix
    ../../modules/home/typescript.nix
  ];

  home.username = "luke.barton";
  home.homeDirectory = if pkgs.stdenv.isDarwin then "/Users/luke.barton" else "/home/luke.barton";
  home.stateVersion = "25.11";

  home.packages = import ../../modules/common.nix { inherit pkgs; }
    ++ (with pkgs; [
    nerd-fonts.blex-mono
    nerd-fonts.go-mono
  ]);
}
