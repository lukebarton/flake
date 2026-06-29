{ ... }: {
  networking.hostName = "blackswan";

  homebrew.brews = [
    "mise"
    {
      name = "postgresql@18";
      link = true;
    }
  ];

  homebrew.casks = [
    "docker-desktop"
  ];

  homebrew.masApps = {
    "Jamf Trust" = 1608041266;
  };
}
