{ pkgs, ... }: {
  # Rust toolchain. cargo needs rustc to build anything, so both come
  # together. Binaries from `cargo install` land in ~/.cargo/bin, outside
  # the nix store.
  home.packages = [
    pkgs.cargo
    pkgs.rustc
  ];

  home.sessionPath = [ "$HOME/.cargo/bin" ];
}
