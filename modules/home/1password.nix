{ pkgs, lib, ... }: {
  home.file.".config/1Password/ssh/agent.toml".source = ../../files/1password/agent.toml;

  home.file.".config/1Password/env".source = ../../files/1password/env;

  home.packages = [
    (pkgs.writeShellApplication {
      name = "op-run";
      text = ''
        env_name="$1"
        shift
        env_file="$HOME/.config/1Password/env/$env_name.env"
        op_args=(--no-masking)
        if [[ -f "$env_file" ]]; then
          op_args+=(--env-file "$env_file")
        fi
        exec op run "''${op_args[@]}" -- zsh -ic "$*"
      '';
    })
  ];

  programs.ssh = {
    enable = true;
    enableDefaultConfig = false;
    settings."*" = {
      IdentityAgent = if pkgs.stdenv.isDarwin
        then "~/Library/Group\\ Containers/2BUA8C4S2C.com.1password/t/agent.sock"
        else "~/.1password/agent.sock";
    };
  };
}
