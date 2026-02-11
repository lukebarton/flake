{ lib, ... }: {
  programs.git.includes = [
    {
      condition = "gitdir:/Users/lukeb/src/github.com/lukebarton/";
      path = "/Users/lukeb/src/github.com/lukebarton/.gitconfig";
    }
  ];

  home.file.".ssh/config".source = ./ssh-config;
}