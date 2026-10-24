# Install with: brew bundle --file ~/dotfiles/Brewfile
# Works with Homebrew on macOS and Linux; casks are macOS-only.

# --- Core workflow ---
brew "git"
brew "stow"
brew "tmux"
brew "neovim"
brew "lazygit"
brew "lazydocker"
brew "gh"

# --- Shell utilities ---
brew "fzf"
brew "ripgrep"
brew "fd"
brew "htop"
brew "just"
brew "coreutils"
brew "gnu-sed"
brew "shellcheck"
brew "pre-commit"

# --- Dev tools ---
brew "awscli"
brew "flyctl"
brew "hf"
brew "repomix"
brew "postgresql@14"
brew "php"

if OS.mac?
  # --- Apps ---
  cask "alacritty"
  cask "visual-studio-code"
  cask "meld"
  cask "bruno"
  cask "gcloud-cli"
  cask "zulu@17"

  # --- Fonts ---
  cask "font-jetbrains-mono-nerd-font"

  # Apple Silicon only
  brew "mlx-lm"
end
