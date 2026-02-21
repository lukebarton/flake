{ ... }: {
  # Ghostty configuration
  home.file.".config/ghostty/config".source = ../../files/ghostty/config;

  # Ghostty shaders
  home.file.".config/ghostty/shaders" = {
    source = ../../files/ghostty/shaders;
    recursive = true;
  };
}
