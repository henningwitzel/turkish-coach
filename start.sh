#!/bin/bash
# Starts or reattaches the Tarkan tmux session.
# Headless-safe: can be called by OpenClaw without a terminal.
# Usage:
#   ./start.sh          — attach if running, else start and attach
#   ./start.sh --detach — start detached (OpenClaw mode), print attach command

SESSION="tarkan"
DIR="$HOME/Development/Turkish-Coach"

DETACH=false
if [[ "$1" == "--detach" ]]; then
  DETACH=true
fi

if tmux has-session -t "$SESSION" 2>/dev/null; then
  if $DETACH; then
    echo "Session '$SESSION' already running."
    echo "Attach with: tmux attach -t $SESSION"
  else
    tmux attach -t "$SESSION"
  fi
else
  tmux new-session -d -s "$SESSION" -c "$DIR" "claude --continue"
  if $DETACH; then
    echo "Session '$SESSION' started."
    echo "Attach with: tmux attach -t $SESSION"
  else
    tmux attach -t "$SESSION"
  fi
fi
