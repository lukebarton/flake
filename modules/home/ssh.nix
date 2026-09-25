{ ... }: {
  programs.ssh = {
    enable = true;
    # IdentityAgent (1Password) is inherited from the "*" block in 1password.nix.
    settings."luke-dev-box" = {
      User = "luke";
      ForwardAgent = "yes";
    };
  };
}
