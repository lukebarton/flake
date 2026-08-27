{ ... }: {
  networking.hostName = "mobius";

  homebrew.casks = [ "nordvpn" ];
  homebrew.brews = [ "googleworkspace-cli" ];
}
