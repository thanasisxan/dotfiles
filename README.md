# dotfiles

macOS + Linux. Managed with [GNU Stow](https://www.gnu.org/software/stow/).

## Setup on a new machine

```sh
git clone git@github.com:thanasisxan/dotfiles.git ~/dotfiles

# Create ~/.ssh first so stow links only the config file, not the whole folder
mkdir -p -m 700 ~/.ssh

cd ~/dotfiles && stow .
```

## Installing tools

### macOS

```sh
brew bundle --file ~/dotfiles/Brewfile
```

Plus: oh-my-zsh, Claude Code (native installer), Alacritty (GitHub releases dmg; the brew cask is disabled).

### Linux (Debian/Ubuntu)

Base system from apt, Homebrew only for tools where apt is too old (neovim for LazyVim, lazygit, lazydocker).

```sh
sudo apt install zsh tmux git stow curl file procps build-essential alacritty
chsh -s "$(command -v zsh)"

# Homebrew (https://brew.sh), then the Brewfile; casks are skipped on Linux
brew bundle --file ~/dotfiles/Brewfile
```

Plus: oh-my-zsh, Claude Code (native installer), Docker from Docker's own apt repo, JetBrainsMono Nerd Font into `~/.local/share/fonts`.

Don't install the same tool through both apt and brew; the brew one wins on PATH.

## Machine-local files (untracked)

- `~/.zshrc.local`: secrets, per-machine env
- `~/.gitconfig.local`: e.g. the macOS Meld difftool path
