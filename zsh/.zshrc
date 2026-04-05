# Prompt: Starship by default, set USE_P10K=1 to use Powerlevel10k
# To use p10k:  USE_P10K=1 zsh

if [[ -n "$USE_P10K" ]]; then
  # Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
  if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
    source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
  fi
fi

export XDG_CONFIG_HOME="$HOME/.config"

# Path configuration
export PATH=$HOME/bin:/usr/local/bin:/Library/Frameworks/Python.framework/Versions/3.11/bin:/Lib/bin:$PATH
export PATH=$PATH:$HOME/.apigeecli/bin
export PATH=$PATH:$HOME/google-cloud-sdk/bin
export PATH=$PATH:$HOME/Lib/flutter/bin
export PATH="/opt/homebrew/opt/openssl@3/bin:$PATH"
export PATH="/opt/homebrew/opt/ruby/bin:$PATH"
export PATH="/opt/homebrew/opt/libpq/bin:$PATH"
export PATH="$HOME/go/bin:$PATH"
export PATH="$HOME/.grove/bin:$PATH"

# Java
export JAVA_HOME=/Users/nicksenap/Library/Java/JavaVirtualMachines/corretto-21.0.6/Contents/Home

# Environment variables
export LDFLAGS="-L/opt/homebrew/opt/openssl@3/lib"
export CPPFLAGS="-I/opt/homebrew/opt/openssl@3/include"
export PKG_CONFIG_PATH="/opt/homebrew/opt/openssl@3/lib/pkgconfig"
export DOCKER_DEFAULT_PLATFORM=linux/amd64
export EDITOR=hx
export POSTHOG_WORKTREE_BASE="$HOME/code/worktrees"

# Oh My Zsh configuration
export ZSH="$HOME/.oh-my-zsh"
if [[ -n "$USE_P10K" ]]; then
  ZSH_THEME="powerlevel10k/powerlevel10k"
else
  ZSH_THEME=""  # Disable oh-my-zsh theme, starship handles prompt
fi
plugins=(git)

# Load Oh My Zsh (only once!)
source $ZSH/oh-my-zsh.sh

# Cache brew prefix to avoid repeated calls
BREW_PREFIX="/opt/homebrew"

# Google Cloud SDK (consolidated)
if [ -f "$BREW_PREFIX/share/google-cloud-sdk/path.zsh.inc" ]; then 
  source "$BREW_PREFIX/share/google-cloud-sdk/path.zsh.inc"
fi
if [ -f "$BREW_PREFIX/share/google-cloud-sdk/completion.zsh.inc" ]; then 
  source "$BREW_PREFIX/share/google-cloud-sdk/completion.zsh.inc"
fi

# Lazy load NVM
export NVM_DIR="$HOME/.nvm"
_load_nvm() {
  unset -f nvm node npm npx
  [ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"
  [ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"
}
nvm() { _load_nvm && nvm "$@"; }
node() { _load_nvm && node "$@"; }
npm() { _load_nvm && npm "$@"; }
npx() { _load_nvm && npx "$@"; }

# Lazy load pyenv
export PYENV_ROOT="$HOME/.pyenv"
export PATH="$PYENV_ROOT/bin:$PATH"
pyenv() {
  unset -f pyenv
  eval "$(command pyenv init -)"
  pyenv "$@"
}

# Aliases
alias ls='eza'
alias ll='ls -l'
alias la='ls -a'
alias lla='ls -la'
alias lt='ls --tree'
alias mvn363='~/Lib/apache-maven-3.6.3/bin/mvn'
alias python='python3'
alias loco='claude --dangerously-skip-permissions'

# Load completions only once
autoload -U +X bashcompinit && bashcompinit
fpath+=~/.zfunc
autoload -Uz compinit
# Only regenerate dump once a day
if [[ -n "${ZSH_COMPDUMP}"  ]]; then
  compinit -C -d "${ZSH_COMPDUMP}"
else
  compinit -C
fi

# Static completions (faster than dynamic)
complete -o nospace -C /opt/homebrew/bin/terraform terraform
complete -o nospace -C /opt/homebrew/bin/terragrunt terragrunt

# Lazy load kubectl completion
kubectl() {
  unset -f kubectl
  source <(command kubectl completion zsh)
  kubectl "$@"
}

vault() {
  cd "/Users/nicksenap/Library/Mobile Documents/iCloud~md~obsidian/Documents/Nick's Vault"
}

# Bun
export BUN_INSTALL="$HOME/.bun"
export PATH="$BUN_INSTALL/bin:$PATH"
[ -s "$BUN_INSTALL/_bun" ] && source "$BUN_INSTALL/_bun"

# pnpm
export PNPM_HOME="/Users/nicksenap/Library/pnpm"
case ":$PATH:" in
  *":$PNPM_HOME:"*) ;;
  *) export PATH="$PNPM_HOME:$PATH" ;;
esac

# Load local environment
[ -f "$HOME/.local/bin/env" ] && . "$HOME/.local/bin/env"

# Prompt setup
if [[ -n "$USE_P10K" ]]; then
  # To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
  [[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh
else
  eval "$(starship init zsh)"
fi

# Task Master aliases added on 9/2/2025
alias tm='task-master'
alias taskmaster='task-master'
[[ -f ~/dev/posthog/bin/phw ]] && source ~/dev/posthog/bin/phw

# Added by Antigravity
export PATH="/Users/nicksenap/.antigravity/antigravity/bin:$PATH"

function y() {
    local tmp="$(mktemp -t "yazi-cwd.XXXXXX")"
    yazi "$@" --cwd-file="$tmp"
    if cwd="$(cat -- "$tmp")" && [ -n "$cwd" ] && [ "$cwd" != "$PWD" ]; then
        builtin cd -- "$cwd"
    fi
    rm -f -- "$tmp"
}


eval "$(gw shell-init)"
export PATH="/Library/Frameworks/Python.framework/Versions/3.12/bin:$PATH"
eval "$(atuin init zsh)"
eval "$(zoxide init zsh)"
