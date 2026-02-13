{ pkgs, lib, ... }: {
  imports = [
    ../configs/1password.nix
    ../configs/aerospace.nix
    ../configs/git.nix
    ../configs/git-grab.nix
    ../configs/ghostty.nix
    #    ../configs/zed.nix
    ../configs/nvim.nix
    ../configs/rclone.nix
    ../configs/starship.nix
  ];

  home.username = "luke";
  home.homeDirectory = "/Users/luke";
  home.stateVersion = "25.11";

  # Fonts
  home.packages = with pkgs; [
    nerd-fonts.blex-mono
    nerd-fonts.go-mono
  ];

  programs.atuin = {
    enable = true;
    enableZshIntegration = true;
    settings = {
      enter_accept = false;
    };
  };

  programs.zoxide = {
    enable = true;
    enableZshIntegration = true;
  };

  programs.zsh = {
    enable = true;
    enableCompletion = true;
    autosuggestion.enable = true;
    syntaxHighlighting.enable = true;

    history = {
      size = 100;
      save = 100;
      expireDuplicatesFirst = true;
      ignoreDups = true;
      ignoreAllDups = true;
      extended = true;
      share = true;
    };

    # Load custom zsh plugins from nix
    plugins = [
      {
        name = "zsh-vi-mode";
        src = "${pkgs.zsh-vi-mode}/share/zsh-vi-mode";
      }
      {
        name = "fzf-tab";
        src = "${pkgs.zsh-fzf-tab}/share/fzf-tab";
      }
      {
        name = "you-should-use";
        src = "${pkgs.zsh-you-should-use}/share/zsh/plugins/you-should-use";
      }
      {
        name = "evalcache";
        src = pkgs.fetchFromGitHub {
          owner = "mroth";
          repo = "evalcache";
          rev = "master";
          sha256 = "sha256-CN9dnSt9kc5AEkWnbtjyv+DCQZ08Ifmac5wELqve17U=";
        };
      }
    ];

    # Custom aliases
    shellAliases = {
      # Homebrew
      brewup = "brew upgrade --cask --greedy --verbose";

      # Git aliases (beyond oh-my-zsh)
      gfl = "git fetch && git pull --autostash";
      gdtl = "git difftool --no-prompt";
      gpot = "git push origin --tags";
      gbc = "git branch --show-current | tr -d '\\n' | pbcopy";
      gmlD = "gswm && gfl && gbgD";
      gbr = "gb -av --sort=-committerdate";

      # Kubernetes
      k = "kubectl";
      kdf = "kubectl diff -f";
      kcc- = "kubectl config unset current-context";

      # Utilities
      cd = "z";
      ugrep = "grep -E '[0-9a-f]{8}-[0-9a-f]{4}-[0-9a-f]{4}-[0-9a-f]{4}-[0-9a-f]{12}'";
      mbtq = "make build && make test-unit && make quality";
      vim = "nvim --cmd \"set loadplugins\"";

      # lsd
      l = "lsd -l";
      la = "lsd -a";
      lla = "lsd -la";
      lt = "lsd --tree";
    };

    sessionVariables = {
      # Editor
      EDITOR = "nvim";
      VISUAL = "nvim";

      # XDG Base Directory
      XDG_CONFIG_HOME = "$HOME/.config";

      # Kubernetes
      KUBECTL_EXTERNAL_DIFF = "dyff between --omit-header --set-exit-code";

      # Docker/Testcontainers (for colima)
      DOCKER_HOST = "unix://$HOME/.config/colima/default/docker.sock";
      TESTCONTAINERS_DOCKER_SOCKET_OVERRIDE = "/var/run/docker.sock";
      TESTCONTAINERS_RYUK_DISABLED = "true";
    };

    initContent = lib.mkMerge [
      (lib.mkBefore ''
        # Homebrew
        eval "$(/opt/homebrew/bin/brew shellenv)"

        # zsh-vi-mode: Initialize when sourced
        ZVM_INIT_MODE=sourcing

        # you-should-use: Show all alias suggestions
        YSU_MODE=ALL
      '')

      (lib.mkOrder 550 ''
        # Completions
        if [[ ":$FPATH:" != *":/Users/luke/.zsh/completions:"* ]]; then
          export FPATH="/Users/luke/.zsh/completions:$FPATH"
        fi

        # Only rebuild completions once per 24 hours for performance
        autoload -Uz +X compaudit compinit
        autoload -Uz +X bashcompinit
        setopt EXTENDEDGLOB
        for dump in $HOME/.zcompdump(N.mh+24); do
          compinit
          bashcompinit
          if [[ -s "$dump" && (! -s "$dump.zwc" || "$dump" -nt "$dump.zwc") ]]; then
            zcompile "$dump"
          fi
        done
        unsetopt EXTENDEDGLOB
        compinit -C
        bashcompinit
      '')

      ''
        # Colima/Testcontainers dynamic host
        export TESTCONTAINERS_HOST_OVERRIDE=$(colima ls -j 2>/dev/null | jq -r '.address' 2>/dev/null || echo "")

        # SSH keys
        ssh-add -A >/dev/null 2>&1

        # kubectl completion for k alias
        [[ $commands[kubectl] ]] && complete -o default -F __start_kubectl k

        # ripgrep->fzf->vim function
        rfv() (
          RELOAD='reload:rg --column --color=always --smart-case {q} || :'
          OPENER='if [[ $FZF_SELECT_COUNT -eq 0 ]]; then
                    nvim {1} +{2}
                  else
                    nvim +cw -q {+f}
                  fi'
          fzf --disabled --ansi --multi \
              --bind "start:$RELOAD" --bind "change:$RELOAD" \
              --bind "enter:become:$OPENER" \
              --bind "ctrl-o:execute:$OPENER" \
              --bind 'alt-a:select-all,alt-d:deselect-all,ctrl-/:toggle-preview' \
              --delimiter : \
              --preview 'bat --style=full --color=always --highlight-line {2} {1}' \
              --preview-window '~4,+{2}+4/3,<80(up)' \
              --query "$*"
        )

        # Use evalcache for slow initialization commands (speeds up shell startup)
        _evalcache direnv hook zsh
        _evalcache starship init zsh
      ''
    ];
  };

  programs.direnv = {
    enable = true;
    enableZshIntegration = false; # Using evalcache for faster init
    nix-direnv.enable = true;
  };
}
