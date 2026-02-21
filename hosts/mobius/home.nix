{ lib, ... }: {
  programs.git.includes = [
    {
      condition = "gitdir:/Users/luke/src/github.com/lukebarton/";
      path = "/Users/luke/src/github.com/lukebarton/.gitconfig";
    }
  ];

  programs.ssh = {
    enable = true;
    extraConfig = ''
      Host *
        IdentityAgent ~/Library/Group\ Containers/2BUA8C4S2C.com.1password/t/agent.sock
    '';
  };

  home.file.".config/rclone/cloud.filters".text = ''
    - .DS_Store
    + /vaults/**
    - **
  '';
}
