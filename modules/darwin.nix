{ pkgs, inputs, ... }: {
  # Let Determinate Nix handle Nix configuration
  nix.enable = false;

  nixpkgs.hostPlatform = "aarch64-darwin";
  nixpkgs.config.allowUnfree = true;

  # Track flake revision
  system.configurationRevision = inputs.self.rev or inputs.self.dirtyRev or null;

  # Define the user
  users.users.luke = {
    home = "/Users/luke";
  };

  # Primary user for system preferences
  system.primaryUser = "luke";

  # Enable fingerprint sudo
  security.pam.services.sudo_local = {
    enable = true;
    touchIdAuth = true;
  };

  # System preferences
  system.defaults = {
    # Dock settings
    dock = {
      autohide = true;
      persistent-apps = [ ];
      persistent-others = [ ];
      show-recents = false;
    };

    # Finder settings
    finder = {
      _FXShowPosixPathInTitle = true;
      FXEnableExtensionChangeWarning = false;
    };

    # Trackpad settings
    trackpad = {
      Clicking = true; # Tap to click
      TrackpadRightClick = true; # Two-finger secondary click
      FirstClickThreshold = 0; # Light click pressure
      SecondClickThreshold = 0; # Light force click pressure
      ActuateDetents = true; # Haptic feedback
      ActuationStrength = 0; # Quiet clicking
      Dragging = false;
      DragLock = false;
      TrackpadThreeFingerDrag = false;
      TrackpadCornerSecondaryClick = 0; # No corner secondary click
      TrackpadThreeFingerTapGesture = 0; # Disabled (force click handles look up)
      TrackpadTwoFingerDoubleTapGesture = true; # Smart zoom
      TrackpadMomentumScroll = true;
      TrackpadPinch = true; # Pinch to zoom
      TrackpadRotate = true; # Two-finger rotate
      TrackpadFourFingerHorizSwipeGesture = 2; # Swipe between full-screen apps
      TrackpadFourFingerVertSwipeGesture = 2; # Mission Control / App Exposé
      TrackpadFourFingerPinchGesture = 2; # Launchpad / Show Desktop
      TrackpadThreeFingerHorizSwipeGesture = 2; # Swipe between pages
      TrackpadThreeFingerVertSwipeGesture = 2; # Mission Control
      TrackpadTwoFingerFromRightEdgeSwipeGesture = 0; # Disabled
    };

    # Keyboard and system settings
    NSGlobalDomain = {
      # Show all file extensions in Finder
      AppleShowAllExtensions = true;
      # Trackpad speed
      "com.apple.trackpad.scaling" = 1.5;
      # Disable autocorrect
      NSAutomaticSpellingCorrectionEnabled = false;
      # Function keys as standard function keys
      "com.apple.keyboard.fnState" = true;
      # Full keyboard access for all controls
      AppleKeyboardUIMode = 3;
      # Disable press-and-hold for keys (enables key repeat for vim)
      ApplePressAndHoldEnabled = false;
      # Fast key repeat
      KeyRepeat = 2;
      InitialKeyRepeat = 15;
      # Drag windows from anywhere with modifier key
      NSWindowShouldDragOnGesture = true;
    };

    # Disable Siri
    CustomUserPreferences = {
      "com.apple.Siri" = {
        "UAProfileCheckingStatus" = 0;
        "siriEnabled" = 0;
      };
      # Disable screenshot keyboard shortcuts
      "com.apple.symbolichotkeys" = {
        AppleSymbolicHotKeys = {
          "28" = { enabled = false; }; # Save picture of screen as a file (⇧⌘3)
          "29" = { enabled = false; }; # Copy picture of screen to clipboard (⌃⇧⌘3)
          "30" = { enabled = false; }; # Save picture of selected area as a file (⇧⌘4)
          "31" = { enabled = false; }; # Copy picture of selected area to clipboard (⌃⇧⌘4)
          "64" = { enabled = false; }; # Spotlight search (⌘Space)
        };
      };
    };
  };

  # Remap Caps Lock to Control
  system.keyboard = {
    enableKeyMapping = true;
    remapCapsLockToControl = true;
  };

  # Homebrew configuration
  homebrew = {
    enable = true;

    taps = [
      "nikitabobko/tap"
    ];

    brews = [
      "filen-cli" # nix pkg won't build. For managing filen api keys for use in rclone
    ];

    casks = [
      "1password"
      "1password-cli"
      "nikitabobko/tap/aerospace"
      "alcove"
      "betterdisplay"
      "claude-code"
      "ghostty"
      "jetbrains-toolbox"
      "raycast"
      "shottr" # Sceenshots
      "zed"
      "zen"
    ];

    masApps = {
      "Amphetamine" = 937984704;
    };

    onActivation = {
      autoUpdate = true;
      cleanup = "zap";
    };
  };

  system.stateVersion = 5;
}
