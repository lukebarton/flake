{ pkgs, ... }: {
  home.packages = with pkgs; [
    colima
    docker
    docker-compose
  ];

  programs.ssh = {
    enable = true;
    includes = [
      "~/.config/colima/ssh_config"
      "~/.colima/ssh_config"
    ];
  };

  programs.zsh.sessionVariables = {
    DOCKER_HOST = "unix://$HOME/.config/colima/default/docker.sock";
    TESTCONTAINERS_DOCKER_SOCKET_OVERRIDE = "/var/run/docker.sock";
    TESTCONTAINERS_RYUK_DISABLED = "true";
  };

  programs.zsh.initContent = ''
    # Colima/Testcontainers dynamic host
    export TESTCONTAINERS_HOST_OVERRIDE=$(colima ls -j 2>/dev/null | jq -r '.address' 2>/dev/null || echo "")
  '';
}
