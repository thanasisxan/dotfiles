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

Nothing identity- or machine-specific is in this repo (it's public). Each machine has:

- `~/.gitconfig.local`: **git name/email** (required: git refuses to commit without it), plus e.g. the macOS Meld difftool path
- `~/.ssh/config.local`: machine-specific SSH hosts and keys (work servers, a work GitHub key)
- `~/.zshrc.local`: secrets, per-machine env

## Updating a machine that already uses this repo

```sh
cd ~/dotfiles
git status            # must be clean; commit or stash local edits first
git pull
stow -n -v .          # dry run: lists new links and any conflicts, changes nothing
```

If the dry run reports conflicts (an existing real file where a link would go), move each one aside, e.g. `mv ~/.gitconfig ~/.gitconfig.bak`, then `stow -v .` and copy what that machine needs from the `.bak` into the matching `*.local` file. stow never overwrites real files on its own. **Never use `stow --adopt`**: it pulls the machine's files into the repo.

Then check identity before committing anything: `git config user.email`.
