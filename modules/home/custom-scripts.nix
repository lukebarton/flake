{ pkgs, ... }: {
  home.packages = [
    (pkgs.writeShellApplication {
      name = "git-grab";
      runtimeInputs = [ pkgs.git pkgs.coreutils ];
      text = builtins.readFile ../../files/git-grab.sh;
    })
    (pkgs.writeShellApplication {
      name = "defaults-to-nix";
      runtimeInputs = [ pkgs.gum pkgs.jq pkgs.python3 ];
      text = builtins.readFile ../../files/defaults-to-nix.sh;
    })
  ];
}
