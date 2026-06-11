{ ... }: {
  networking.hostName = "blackswan";

  homebrew.brews = [
    "mise"
  ];

  homebrew.masApps = {
    "Jamf Trust" = 1608041266;
  };
}
