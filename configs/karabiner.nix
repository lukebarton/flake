{ pkgs, lib, ... }:
{
  # env var for the goku config, tidy
  programs.zsh.sessionVariables.GOKU_EDN_CONFIG_FILE = "/Users/luke/src/github.com/lukebarton/flake/files/karabiner/karabiner.edn";

  # Build it once upon activation
  home.activation.goku = lib.hm.dag.entryAfter [ "writeBoundary" ] ''
    export GOKU_EDN_CONFIG_FILE=${../files/karabiner/karabiner.edn}
    run ${pkgs.goku}/bin/goku
  '';
}
