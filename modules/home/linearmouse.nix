{ pkgs, ... }: {

  # linearmouse config file
  home.file.".config/linearmouse/linearmouse.json".source = ../../files/linearmouse.json;

  # LinearMouse default settings
  targets.darwin.defaults."com.lujjjh.LinearMouse" = {
    showInDock = false;
    showInMenuBar = false;
  };

}
