# Cross-platform zshrc (macOS & Ubuntu)

# -----------------------------------------------------------------------------
# OS Detection
# -----------------------------------------------------------------------------
case "$(uname -s)" in
  Darwin) OS="macos" ;;
  Linux)  OS="linux" ;;
  *)      OS="unknown" ;;
esac

# -----------------------------------------------------------------------------
# Homebrew (before oh-my-zsh for proper PATH)
# -----------------------------------------------------------------------------
if [[ "$OS" == "macos" ]]; then
  [[ -f /opt/homebrew/bin/brew ]] && eval "$(/opt/homebrew/bin/brew shellenv)"
elif [[ "$OS" == "linux" ]]; then
  [[ -f /home/linuxbrew/.linuxbrew/bin/brew ]] && eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"
  [[ -f /usr/bin/brew ]] && eval "$(/usr/bin/brew shellenv)"
fi

# -----------------------------------------------------------------------------
# Oh My Zsh
# -----------------------------------------------------------------------------
export ZSH="$HOME/.oh-my-zsh"
ZSH_THEME="robbyrussell"

plugins=(git ssh docker docker-compose history rsync ssh-agent stripe)

# ssh-agent plugin config
zstyle :omz:plugins:ssh-agent lazy yes
if [[ "$OS" == "macos" ]]; then
  zstyle :omz:plugins:ssh-agent ssh-add-args --apple-load-keychain
fi

source $ZSH/oh-my-zsh.sh

# -----------------------------------------------------------------------------
# Environment
# -----------------------------------------------------------------------------
export LANG=en_US.UTF-8

# nvim for quick in-terminal edits; VS Code is for browsing (see lazygit config)
export EDITOR='nvim'
export VISUAL='nvim'

# Same lazygit config path on macOS and Linux
export LG_CONFIG_FILE="$HOME/.config/lazygit/config.yml"

# fzf colors (JetBrains dark, from jb.nvim extras)
export FZF_DEFAULT_OPTS_FILE="$HOME/.config/fzf/jb-dark.fzfrc"

# -----------------------------------------------------------------------------
# PATH additions (cross-platform)
# -----------------------------------------------------------------------------
# Local bin
[[ -d "$HOME/.local/bin" ]] && export PATH="$HOME/.local/bin:$PATH"

# Emacs
[[ -d "$HOME/.config/emacs/bin" ]] && export PATH="$HOME/.config/emacs/bin:$PATH"

# JetBrains Toolbox
if [[ "$OS" == "macos" ]]; then
  [[ -d "$HOME/Library/Application Support/JetBrains/Toolbox/scripts" ]] && \
    export PATH="$PATH:$HOME/Library/Application Support/JetBrains/Toolbox/scripts"
elif [[ "$OS" == "linux" ]]; then
  [[ -d "$HOME/.local/share/JetBrains/Toolbox/scripts" ]] && \
    export PATH="$PATH:$HOME/.local/share/JetBrains/Toolbox/scripts"
fi

# Java & Android SDK
if [[ "$OS" == "macos" ]]; then
  JAVA_HOME="$(/usr/libexec/java_home -v 17 2>/dev/null)" && export JAVA_HOME
  export ANDROID_HOME="$HOME/Library/Android/sdk"
elif [[ "$OS" == "linux" ]]; then
  export ANDROID_HOME="$HOME/Android/Sdk"
fi
if [[ -d "$ANDROID_HOME" ]]; then
  export PATH="$PATH:$ANDROID_HOME/emulator:$ANDROID_HOME/platform-tools"
fi

# -----------------------------------------------------------------------------
# Machine-local overrides (untracked: secrets, per-machine paths)
# -----------------------------------------------------------------------------
[[ -f "$HOME/.zshrc.local" ]] && source "$HOME/.zshrc.local"

# -----------------------------------------------------------------------------
# Docker completions
# -----------------------------------------------------------------------------
if [[ -d "$HOME/.docker/completions" ]]; then
  fpath=("$HOME/.docker/completions" $fpath)
  autoload -Uz compinit
  compinit
fi

# -----------------------------------------------------------------------------
# Tool-specific env files
# -----------------------------------------------------------------------------
[[ -f "$HOME/.local/bin/env" ]] && . "$HOME/.local/bin/env"
[[ -f "$HOME/.cargo/env" ]] && . "$HOME/.cargo/env"

# -----------------------------------------------------------------------------
# Aliases
# -----------------------------------------------------------------------------
alias sail='sh $([ -f sail ] && echo sail || echo vendor/bin/sail)'
alias lg="lazygit"
alias ld="lazydocker"
