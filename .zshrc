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

plugins=(git ssh docker docker-compose history rsync ssh-agent)

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

if [[ -n $SSH_CONNECTION ]]; then
  export EDITOR='vim'
else
  export EDITOR='nvim'
fi

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
