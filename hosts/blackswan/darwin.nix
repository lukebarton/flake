{ ... }: {
  networking.hostName = "blackswan";

  homebrew.brews = [
    "mise"
    "postgresql@18"
  ];

  homebrew.casks = [
    "docker-desktop"
  ];

  homebrew.masApps = {
    "Jamf Trust" = 1608041266;
  };
}
