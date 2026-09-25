{ pkgs, lib, ... }: {
  # uv — Python package/tool manager. Tools installed with `uv tool install`
  # live in ~/.local/share/uv/tools with entrypoints in ~/.local/bin,
  # outside the nix store.
  home.packages = [ pkgs.uv ];

  # uv tools to keep installed. Re-run on every activation so new entries
  # get installed and existing ones are upgraded.
  home.activation.uvTools = lib.hm.dag.entryAfter [ "writeBoundary" ] ''
    export PATH="${pkgs.uv}/bin:$PATH"
    for tool in claude-swap; do
      run uv tool install --quiet --upgrade "$tool"
    done
  '';

  home.sessionPath = [ "$HOME/.local/bin" ];
}
