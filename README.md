# nix-darwin configuration

Declarative macOS configuration using nix-darwin, home-manager, and flakes.

## Bootstrap

On a fresh Mac, run:

```bash
curl -fsSL https://raw.githubusercontent.com/lukebarton/flake/main/bootstrap.sh | bash
```

This will install Xcode CLT, clone the repo to `~/src/github.com/lukebarton/flake`, and run `make bootstrap` which handles Nix, Homebrew, hostname selection, building, and activation.

## Usage

```bash
make switch    # Build and activate the configuration
make build     # Test without applying
make update    # Update flake inputs
make check     # Validate flake
make fmt       # Format nix files
make hostname  # Set machine hostname to a supported configuration
make init      # Set up git hooks
```

## Adding Packages

**CLI tools:** Add to `modules/common.nix`

**GUI apps:** Add to `modules/darwin.nix` under `homebrew.casks`

**Language toolchains:** Use per-project nix dev shells instead of global installs.

## Manual Steps

**Kanata Input Monitoring:** After the first build (or after a kanata package update), grant Input Monitoring access in **System Settings > Privacy & Security > Input Monitoring** for the kanata binary at `/etc/profiles/per-user/luke/bin/kanata`. The Nix store path it symlinks to changes on package updates, so you may need to re-approve it.

## Troubleshooting

**Git signing fails:** Ensure 1Password is running with SSH agent enabled

**Homebrew not found:** Restart terminal after initial activation

**Changes not applying:** Some preferences require logout/restart

## References

- [nix-darwin](https://github.com/LnL7/nix-darwin)
- [home-manager](https://nix-community.github.io/home-manager/)
- [ekarcnevets flake](https://github.com/ekarcnevets/flake)