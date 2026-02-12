{ lib, ... }: {
  programs.git.includes = [
    {
      condition = "gitdir:/Users/luke/src/github.com/lukebarton/";
      path = "/Users/luke/src/github.com/lukebarton/.gitconfig";
    }
  ];

  home.file.".ssh/config".source = ./ssh-config;
}
