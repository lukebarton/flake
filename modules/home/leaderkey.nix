{ config, ... }:
let
  homeDir = config.home.homeDirectory;
in {
  targets.darwin.defaults."com.brnbw.Leader-Key" = {
    configDir = "${homeDir}/src/github.com/lukebarton/flake/files/leader-key";
    showDetailsInCheatsheet = 0;
    theme = "cheater";
  };
}
