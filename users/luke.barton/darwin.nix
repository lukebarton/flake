{ ... }: {
  users.users."luke.barton" = {
    home = "/Users/luke.barton";
  };

  system.primaryUser = "luke.barton";
}
