{ ... }: {
  # Config
  home.file.".config/aerospace/aerospace.toml".source = ../files/aerospace/aerospace.toml;

  # Sticky windows script
  home.file.".config/aerospace/sticky-windows.sh".source = ../files/aerospace/sticky-windows.sh;
}
