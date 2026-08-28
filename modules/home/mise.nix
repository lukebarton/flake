{ ... }: {
  # mise — dev tool version manager. Its runtimes/shims live in
  # ~/.local/share/mise, outside the nix store.
  programs.mise.enable = true;
  programs.mise.enableZshIntegration = true;

}
