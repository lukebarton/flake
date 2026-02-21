{ pkgs, ... }: {
  users.users.luke = {
    isNormalUser = true;
    home = "/home/luke";
    shell = pkgs.zsh;
    extraGroups = [ "wheel" "networkmanager" ];
  };
}
