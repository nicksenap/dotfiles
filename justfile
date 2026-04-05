home := env("HOME")
packages := "aerospace atuin helix karabiner nushell yazi zellij zsh"

# List available recipes
default:
    @just --list

# Stow all packages
stow:
    stow -t {{ home }} {{ packages }}

# Unstow all packages
unstow:
    stow -t {{ home }} -D {{ packages }}

# Restow all packages (useful after adding new files)
restow:
    stow -t {{ home }} -R {{ packages }}

# Stow a single package
add package:
    stow -t {{ home }} {{ package }}

# Unstow a single package
remove package:
    stow -t {{ home }} -D {{ package }}

# Show what would be stowed (dry run)
plan:
    stow -t {{ home }} -n -v {{ packages }}

# Install dependencies via Homebrew
deps:
    brew install stow starship atuin yazi helix zellij eza just
    brew install --cask nikitabobko/tap/aerospace
