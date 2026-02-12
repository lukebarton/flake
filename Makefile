.PHONY: bootstrap init switch build update clean check fmt help nix homebrew hostname

HOSTS := $(sort $(notdir $(wildcard hosts/*)))

# Default target
help:
	@echo "Available targets:"
	@echo "  make bootstrap - Full setup: install deps, build, activate, init"
	@echo "  make hostname  - Set machine hostname to a supported configuration"
	@echo "  make switch    - Build and activate the configuration"
	@echo "  make build     - Build the configuration without activating"
	@echo "  make update    - Update flake inputs"
	@echo "  make clean     - Remove build artifacts"
	@echo "  make check     - Check flake for errors"
	@echo "  make fmt       - Format nix files"
	@echo "  make init      - Set up git hooks"
	@echo "  make help      - Show this help message"

# Full bootstrap: install deps, set hostname, build, activate, init
bootstrap: nix homebrew hostname switch init
	@printf '\033[1;34m==> Done! Restart your shell: exec zsh\033[0m\n'

# Ensure hostname matches a supported configuration
hostname:
	@current=$$(hostname | cut -d. -f1); \
	valid=false; \
	for h in $(HOSTS); do \
		[ "$$h" = "$$current" ] && valid=true; \
	done; \
	if $$valid; then \
		printf '\033[1;34m==> Hostname "%s" matches a configuration\033[0m\n' "$$current"; \
	else \
		printf '\033[1;33m==> Hostname "%s" does not match any configuration.\033[0m\n' "$$current"; \
		printf 'Available hosts:\n'; \
		i=1; \
		for h in $(HOSTS); do \
			printf '  %d) %s\n' "$$i" "$$h"; \
			i=$$((i + 1)); \
		done; \
		printf '\n'; \
		while true; do \
			printf 'Select a hostname [1-%d]: ' $$(echo $(HOSTS) | wc -w | tr -d ' '); \
			read choice; \
			i=1; \
			for h in $(HOSTS); do \
				if [ "$$i" = "$$choice" ]; then \
					selected="$$h"; \
					break; \
				fi; \
				i=$$((i + 1)); \
			done; \
			[ -n "$${selected:-}" ] && break; \
			printf 'Invalid selection, try again.\n'; \
		done; \
		printf '\033[1;34m==> Renaming machine to "%s"...\033[0m\n' "$$selected"; \
		sudo scutil --set ComputerName "$$selected"; \
		sudo scutil --set HostName "$$selected"; \
		sudo scutil --set LocalHostName "$$selected"; \
		printf '\033[1;34m==> Hostname set to "%s"\033[0m\n' "$$selected"; \
	fi

# Install Nix if missing
nix:
	@if command -v nix >/dev/null 2>&1; then \
		printf '\033[1;34m==> Nix already installed\033[0m\n'; \
	else \
		printf '\033[1;34m==> Installing Nix...\033[0m\n'; \
		curl -fsSL https://install.determinate.systems/nix | sh -s -- install; \
	fi

# Install Homebrew if missing
homebrew:
	@if command -v brew >/dev/null 2>&1; then \
		printf '\033[1;34m==> Homebrew already installed\033[0m\n'; \
	else \
		printf '\033[1;34m==> Installing Homebrew...\033[0m\n'; \
		/bin/bash -c "$$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"; \
	fi

# Build and activate the configuration (re-evaluate hostname at recipe time)
switch:
	sudo darwin-rebuild switch --flake .#$$(hostname | cut -d. -f1)

# Build without activating
build:
	darwin-rebuild build --flake .#$$(hostname | cut -d. -f1)

# Update flake inputs
update:
	nix flake update

# Remove build artifacts
clean:
	rm -rf result result-*

# Check flake for errors
check:
	nix flake check

# Format nix files
fmt:
	fd -e nix -X nix fmt --

# Set up git hooks
init:
	git config core.hooksPath .githooks
