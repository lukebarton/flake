{ pkgs, lib, ... }: {
  home.file.".config/1Password/ssh/agent.toml".source = ../../files/1password/agent.toml;

  home.packages = [
    (pkgs.writeShellApplication {
      name = "op-run-zsh";
      text = ''exec op run --no-masking -- zsh -ic "$*"'';
    })
  ];

  programs.ssh = {
    enable = true;
    enableDefaultConfig = false;
    matchBlocks."*" = {
      extraOptions = {
        IdentityAgent = if pkgs.stdenv.isDarwin
          then "~/Library/Group\\ Containers/2BUA8C4S2C.com.1password/t/agent.sock"
          else "~/.1password/agent.sock";
      };
    };
  };
}
