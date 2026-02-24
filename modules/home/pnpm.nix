{ pkgs, lib, ... }: {
  home.packages = [ pkgs.pnpm ];

  home.activation.pnpmGlobalPackages = lib.hm.dag.entryAfter [ "writeBoundary" ] ''
    ${pkgs.pnpm}/bin/pnpm add -g @mariozechner/pi-coding-agent
  '';

  programs.zsh.sessionVariables = {
    PNPM_HOME = "$HOME/.local/share/pnpm";
  };

  programs.zsh.envExtra = ''
    export PATH="$PNPM_HOME:$PATH"
  '';
}