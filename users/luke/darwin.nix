{ ... }: {
  users.users.luke = {
    home = "/Users/luke";
  };

  system.primaryUser = "luke";

  # macOS-only home-manager modules (GUI apps, app defaults, Colima, 1Password agent)
  home-manager.users.luke.imports = [
    ../../modules/home/1password.nix
    ../../modules/home/aerospace.nix
    ../../modules/home/colima.nix
    ../../modules/home/ghostty.nix
    ../../modules/home/ideavim.nix
    ../../modules/home/leaderkey.nix
    ../../modules/home/linearmouse.nix
    ../../modules/home/misc-app-defaults.nix
  ];
}
