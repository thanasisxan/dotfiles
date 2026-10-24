# dotfiles

macOS + Linux. Managed with [GNU Stow](https://www.gnu.org/software/stow/).

## Setup on a new machine

```sh
git clone git@github.com:thanasisxan/dotfiles.git ~/dotfiles

# Create ~/.ssh first so stow links only the config file, not the whole folder
mkdir -p -m 700 ~/.ssh

cd ~/dotfiles && stow .
```

Needs: `stow zsh tmux nvim lazygit lazydocker`, oh-my-zsh, JetBrainsMono Nerd Font.

## Machine-local files (untracked)

- `~/.zshrc.local`: secrets, per-machine env
- `~/.gitconfig.local`: e.g. the macOS Meld difftool path
