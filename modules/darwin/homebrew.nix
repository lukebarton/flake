{ ... }: {
  homebrew = {
    enable = true;

    taps = [
      "kamillobinski/thock"
      "nikitabobko/tap"
    ];

    brews = [
      "filen-cli" # nix pkg won't build. For managing filen api keys for use in rclone
      "mas" # required by brew bundle for masApps; declared so cleanup doesn't churn it
    ];

    casks = [
      "1password"
      "1password-cli"
      "nikitabobko/tap/aerospace"
      "alcove"
      "antinote"
      "betterdisplay"
      "claude-code@latest"
      "clop" # image+video compressor when files land on desktop
      "displaylink" # for Elgato Teleprompter
      "discord"
      "elgato-stream-deck"
      "ghostty"
      "google-chrome"
      "grammarly-desktop"
      "jetbrains-toolbox"
      "karabiner-elements" # input manipulation
      "leader-key" # leader key w/ which-key, but for mac
      "linearmouse"
      "macwhisper"
      "obsidian"
      "presentify"
      "raycast"
      "rodecaster"
      "shottr" # Sceenshots
      "kamillobinski/thock/thock" # keyboard sounds, ikr?
      "whatsapp"
      "wooshy" # easymotion/acejump for mac
      "visual-studio-code"
      "zed"
      "zen"
    ];

    masApps = {
      "Dropover" = 1355679052;
      "Dato" = 1470584107; # Calendar toolbar
    };

    onActivation = {
      autoUpdate = true;
      cleanup = "zap";
      # Homebrew 5.1.15 requires explicit confirmation for `brew bundle install --cleanup`.
      # Remove once nix-darwin#1787 lands.
      extraFlags = [ "--force-cleanup" ];
    };
  };
}
