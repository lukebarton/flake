{ pkgs, ... }: {
  programs.atuin = {
    enable = true;
    enableZshIntegration = true;
    settings = {
      enter_accept = false;
      filter_mode = "directory";
    };
  };

  programs.zoxide = {
    enable = true;
    enableZshIntegration = true;
  };

  programs.direnv = {
    enable = true;
    enableZshIntegration = false; # Using evalcache for faster init
    nix-direnv.enable = true;
    config.global.bash_path = "${pkgs.bash}/bin/bash"; # macOS /bin/bash is 3.2; direnv's stdlib needs 4+
  };
}
