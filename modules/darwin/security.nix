{ ... }: {
  # Enable fingerprint sudo
  security.pam.services.sudo_local = {
    enable = true;
    touchIdAuth = true;
    watchIdAuth = true; # use apple watch for auth, if available
  };
}
