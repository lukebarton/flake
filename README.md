# nix-darwin configuration

Declarative macOS configuration using nix-darwin, home-manager, and flakes.

## Prerequisites

1. Install Nix:
   ```bash
   curl -fsSL https://install.determinate.systems/nix | sh -s -- install
   ```
2. Install Homebrew (for GUI applications):
   ```bash
   /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
   ```

## Setup

**First time on a new machine:**

```bash
# 1. Test the build first
nix run nix-darwin -- build --flake .#$(hostname | cut -d. -f1)

# 2. If build succeeds, apply the configuration
sudo nix run nix-darwin -- switch --flake .#$(hostname | cut -d. -f1)

# 3. Set up git hooks
make init

# 4. Restart shell
exec zsh
```

**After initial setup (regular usage):**

```bash
sudo make switch   # Apply configuration changes
make build         # Test without applying
make update        # Update flake inputs
make check         # Validate flake
make fmt           # Format nix files
```

## Adding Packages

**CLI tools:** Add to `modules/common.nix`

**GUI apps:** Add to `modules/darwin.nix` under `homebrew.casks`

**Language toolchains:** Use per-project nix dev shells instead of global installs.

## Troubleshooting

**Git signing fails:** Ensure 1Password is running with SSH agent enabled

**Homebrew not found:** Restart terminal after initial activation

**Changes not applying:** Some preferences require logout/restart

## References

- [nix-darwin](https://github.com/LnL7/nix-darwin)
- [home-manager](https://nix-community.github.io/home-manager/)
- [ekarcnevts flake](https://github.com/ekarcnevets/flake)