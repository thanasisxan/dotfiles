#!/usr/bin/env bash
# Called by Claude Code hooks (see README) to show Claude's state in tmux.
# Usage: claude-state.sh start|working|input|idle|end
# Sets the pane option @claude_state (window names show it as ● or !) and turns
# the pane header on only in windows running Claude. Does nothing outside tmux.

[[ -n "$TMUX_PANE" ]] || exit 0
pane="$TMUX_PANE"

case "$1" in
  start)
    tmux set -w -t "$pane" pane-border-status top
    tmux set -p -t "$pane" @claude_state idle
    ;;
  working)
    # Also turns the header on, for sessions started before the hooks existed
    tmux set -w -t "$pane" pane-border-status top
    tmux set -p -t "$pane" @claude_state working
    ;;
  input | idle)
    tmux set -p -t "$pane" @claude_state "$1"
    ;;
  end)
    tmux set -p -u -t "$pane" @claude_state
    # Drop the header unless another pane in this window still runs Claude
    if [[ -z "$(tmux list-panes -t "$pane" -F '#{@claude_state}' | tr -d '\n')" ]]; then
      tmux set -w -u -t "$pane" pane-border-status
    fi
    ;;
esac 2>/dev/null

exit 0
