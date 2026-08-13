{ ... }: {
  networking.hostName = "mobius";

  homebrew.casks = [ "nordvpn" ];
  homebrew.brews = [ "mise" "googleworkspace-cli" ];
}
