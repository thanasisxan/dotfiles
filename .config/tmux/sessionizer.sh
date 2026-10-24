#!/usr/bin/env bash
# Pick a project with fzf, then switch to its tmux session (created if missing).
# Works from inside tmux (prefix f) or from a plain shell.

selected=$(
  {
    find "$HOME/repos" -mindepth 1 -maxdepth 1 -type d 2>/dev/null
    echo "$HOME/dotfiles"
  } | sort | fzf --prompt="project> " --reverse
)
[[ -z "$selected" ]] && exit 0

# tmux session names can't contain dots or colons
name=$(basename "$selected" | tr '.:' '__')

tmux has-session -t "=$name" 2>/dev/null || tmux new-session -ds "$name" -c "$selected"

if [[ -n "$TMUX" ]]; then
  tmux switch-client -t "=$name"
else
  tmux attach -t "=$name"
fi
