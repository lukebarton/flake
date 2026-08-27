{ inputs, ... }: {
  imports = [
    ./nix.nix
    ./system.nix
    ./homebrew.nix
    ./security.nix
    ./kanata.nix
    ./karabiner.nix
    ./mise.nix
  ];

  system.configurationRevision = inputs.self.rev or inputs.self.dirtyRev or null;
}
