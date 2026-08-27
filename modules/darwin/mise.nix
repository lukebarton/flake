{ ... }: {
  # mise — dev tool version manager. Installed via brew so it can manage
  # its own runtimes/shims outside the nix store.
  homebrew.brews = [ "mise" ];

  home-manager.sharedModules = [
    {
      programs.zsh.initContent = ''
        # Activate mise
        _evalcache mise activate zsh
      '';
    }
  ];
}
