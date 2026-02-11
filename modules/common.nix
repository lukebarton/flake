{ pkgs, ... }:

with pkgs; [
  # Core utilities
  coreutils
  curl
  wget

  # Version control
  git
  gh # GitHub CLI
  lazygit # TUI for git
  diff-so-fancy # Better git diffs

  # JSON/YAML tools
  jq
  yq-go
  dyff # YAML diff tool

  # Modern CLI replacements
  ripgrep # better grep
  fd # better find
  bat # better cat
  eza # better ls
  atuin # better history
  zoxide # better z

  # Development tools
  fzf
  tree
  btop # Better system monitor than htop
  biome # Fast formatter for JS/TS/JSON/CSS
  gnumake # GNU Make build tool

  # System Python (for system scripts and tools)
  python3

  # Container tools
  colima # Container runtime for macOS
  docker # Docker CLI
  docker-compose # Docker Compose CLI

  # Kubernetes tools
  kubectl # Kubernetes CLI
  kubernetes-helm # Helm package manager
  helm-docs # Generate docs from Helm charts
  k9s # Terminal UI for Kubernetes
  kubie # Kubernetes context/namespace switcher
  teleport # Teleport shell (tsh) for secure access

  # AWS tools
  awscli2 # AWS CLI
  aws-sam-cli # AWS SAM CLI

  # Zsh plugins
  zsh-vi-mode
  zsh-fzf-tab
  zsh-you-should-use
]