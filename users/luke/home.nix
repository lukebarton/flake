{ pkgs, ... }: {
  # Cross-platform modules; macOS-only ones live in ./darwin.nix
  imports = [
    ../../modules/home/shell.nix
    ../../modules/home/ssh.nix
    ../../modules/home/claude.nix
    ../../modules/home/programs.nix
    ../../modules/home/git.nix
    ../../modules/home/custom-scripts.nix
    ../../modules/home/mise.nix
    ../../modules/home/nvim.nix
    ../../modules/home/pnpm.nix
    ../../modules/home/rclone.nix
    ../../modules/home/rust.nix
    ../../modules/home/starship.nix
    ../../modules/home/typescript.nix
    ../../modules/home/uv.nix
  ];

  home.username = "luke";
  home.homeDirectory = if pkgs.stdenv.hostPlatform.isDarwin then "/Users/luke" else "/home/luke";
  home.stateVersion = "25.11";

  home.packages = import ../../modules/common.nix { inherit pkgs; }
    ++ (with pkgs; [
    nerd-fonts.blex-mono
    nerd-fonts.go-mono
  ]);
}
