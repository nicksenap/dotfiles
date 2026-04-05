home := env("HOME")
packages := "aerospace atuin helix karabiner nushell yazi zellij zsh"
plugin_dir := home / ".config/zellij/plugins"

zjstatus_version := "v0.22.0"
monocle_version := "v0.100.2"

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

# Download zellij plugins
plugins:
    mkdir -p {{ plugin_dir }}
    curl -fsSL -o {{ plugin_dir }}/zjstatus.wasm \
        "https://github.com/dj95/zjstatus/releases/download/{{ zjstatus_version }}/zjstatus.wasm"
    curl -fsSL -o {{ plugin_dir }}/monocle.wasm \
        "https://github.com/imsnif/monocle/releases/download/{{ monocle_version }}/monocle.wasm"
    @echo "Downloaded zjstatus {{ zjstatus_version }} and monocle {{ monocle_version }}"

# Install dependencies via Homebrew
deps:
    brew install stow starship atuin yazi helix zellij eza just
    brew install --cask nikitabobko/tap/aerospace

# Full setup: deps, stow, plugins
setup: deps stow plugins
