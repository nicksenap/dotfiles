# Cargo env (adds ~/.cargo/bin to PATH)
source $"($nu.home-dir)/.cargo/env.nu"

# ── Aliases ──────────────────────────────────────
alias ll = ls
alias mvn363 = ~/Lib/apache-maven-3.6.3/bin/mvn
alias python = python3
alias loco = claude --dangerously-skip-permissions
alias tm = task-master
alias taskmaster = task-master

# ── Custom commands ──────────────────────────────

# cd into Obsidian vault
def vault [] {
    cd "/Users/nicksenap/Library/Mobile Documents/iCloud~md~obsidian/Documents/Nick's Vault"
}

# Yazi file manager with cwd tracking
def --env y [...args: string] {
    let tmp = (mktemp -t "yazi-cwd.XXXXXX")
    yazi ...$args --cwd-file $tmp
    let cwd = (open $tmp | str trim)
    if $cwd != "" and $cwd != $env.PWD {
        cd $cwd
    }
    rm -f $tmp
}

# Grove (gw) — worktree navigation wrapper
def --env --wrapped gw [...args: string] {
    if ($args | length) > 0 and $args.0 == "go" {
        let output = (^gw ...$args | str trim)
        if ($output | path exists) {
            cd $output
        } else {
            print $output
        }
    } else if ($args | length) > 0 and $args.0 == "create" {
        let tmp = (mktemp -t ".grove_cd.XXXXXX")
        with-env { GROVE_CD_FILE: $tmp } { ^gw ...$args }
        let dir = (open $tmp | str trim)
        if $dir != "" and ($dir | path exists) {
            cd $dir
        }
        rm -f $tmp
    } else {
        ^gw ...$args
    }
}

# ── Shell integrations ──────────────────────────

# Zoxide (smarter cd) — regenerate with: zoxide init nushell > ~/.config/nushell/zoxide.nu
source zoxide.nu

# Atuin (shell history) — regenerate with: atuin init nu --disable-up-arrow > ~/.config/nushell/atuin.nu
source atuin.nu

# ── Prompt (starship) ────────────────────────────
use ~/.cache/starship/init.nu

# ── Settings ─────────────────────────────────────
$env.config.show_banner = false
$env.config.keybindings = ($env.config.keybindings | append {
    name: clear_screen
    modifier: control
    keycode: char_l
    mode: [emacs vi_normal vi_insert]
    event: { send: ClearScrollback }
})
