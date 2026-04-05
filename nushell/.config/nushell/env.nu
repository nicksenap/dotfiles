# Environment variables
$env.XDG_CONFIG_HOME = $"($nu.home-dir)/.config"
$env.EDITOR = "hx"
$env.DOCKER_DEFAULT_PLATFORM = "linux/amd64"
$env.POSTHOG_WORKTREE_BASE = $"($nu.home-dir)/code/worktrees"

# Java
$env.JAVA_HOME = "/Users/nicksenap/Library/Java/JavaVirtualMachines/corretto-21.0.6/Contents/Home"

# Build flags
$env.LDFLAGS = "-L/opt/homebrew/opt/openssl@3/lib"
$env.CPPFLAGS = "-I/opt/homebrew/opt/openssl@3/include"
$env.PKG_CONFIG_PATH = "/opt/homebrew/opt/openssl@3/lib/pkgconfig"

# Pyenv
$env.PYENV_ROOT = $"($nu.home-dir)/.pyenv"

# Bun
$env.BUN_INSTALL = $"($nu.home-dir)/.bun"

# pnpm
$env.PNPM_HOME = "/Users/nicksenap/Library/pnpm"

# NVM directory (for tools that reference it, but nvm itself doesn't work in nushell)
$env.NVM_DIR = $"($nu.home-dir)/.nvm"

# PATH configuration
use std/util "path add"

path add "/opt/homebrew/bin"
path add $"($nu.home-dir)/bin"
path add "/usr/local/bin"
path add "/Library/Frameworks/Python.framework/Versions/3.12/bin"
path add "/Library/Frameworks/Python.framework/Versions/3.11/bin"
path add $"($nu.home-dir)/.apigeecli/bin"
path add $"($nu.home-dir)/google-cloud-sdk/bin"
path add $"($nu.home-dir)/Lib/flutter/bin"
path add "/opt/homebrew/opt/openssl@3/bin"
path add "/opt/homebrew/opt/ruby/bin"
path add "/opt/homebrew/opt/libpq/bin"
path add $"($nu.home-dir)/go/bin"
path add $"($nu.home-dir)/.grove/bin"
path add $"($nu.home-dir)/.bun/bin"
path add "/Users/nicksenap/Library/pnpm"
path add $"($nu.home-dir)/.pyenv/bin"
path add $"($nu.home-dir)/.cargo/bin"
path add "/Users/nicksenap/.antigravity/antigravity/bin"
