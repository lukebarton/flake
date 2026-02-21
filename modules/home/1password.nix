{ pkgs, ... }: {
  home.file.".config/1Password/ssh/agent.toml".source = ../../files/1password/agent.toml;

  home.packages = [
    (pkgs.writeShellApplication {
      name = "op-run-zsh";
      text = ''exec op run --no-masking -- zsh -ic "$*"'';
    })
  ];
}
