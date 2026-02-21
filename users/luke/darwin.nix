{ ... }: {
  users.users.luke = {
    home = "/Users/luke";
  };

  system.primaryUser = "luke";
}
