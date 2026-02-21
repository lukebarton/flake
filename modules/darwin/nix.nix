{ ... }: {
  # Let Determinate Nix handle Nix configuration
  nix.enable = false;

  nixpkgs.config.allowUnfree = true;
}
