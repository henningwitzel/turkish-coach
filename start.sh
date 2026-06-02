#!/bin/bash
# Starts or reattaches the Tarkan tmux session.
# Headless-safe: can be called by OpenClaw without a terminal.
# Usage:
#   ./start.sh           — attach if running, else start and attach
#   ./start.sh --detach  — start detached (OpenClaw mode), print attach command
#   ./start.sh --remote  — start detached + activate /remote-control for Claude App

SESSION="tarkan"
DIR="$HOME/Development/Turkish-Coach"

MODE="attach"
if [[ "$1" == "--detach" ]]; then MODE="detach"; fi
if [[ "$1" == "--remote" ]]; then MODE="remote"; fi

# Always pull latest — runs on every call, including daily restarts
git -C "$DIR" pull --ff-only --quiet 2>/dev/null && echo "Updated." || echo "Offline or up to date."

FRESH=false
if tmux has-session -t "$SESSION" 2>/dev/null; then
  echo "Session '$SESSION' already running."
else
  tmux new-session -d -s "$SESSION" -c "$DIR" "claude --continue"
  echo "Session '$SESSION' started."
  FRESH=true
fi

case "$MODE" in
  attach)
    tmux attach -t "$SESSION"
    ;;
  detach)
    echo "Attach with: tmux attach -t $SESSION"
    ;;
  remote)
    if $FRESH; then
      echo "Waiting for Claude to initialize..."
      sleep 10
    fi
    tmux send-keys -t "${SESSION}:0.0" "/remote-control" Enter
    # /remote-control opens an interactive menu — send Enter to select "Continue"
    sleep 3
    tmux send-keys -t "${SESSION}:0.0" "" Enter
    echo "Remote control activated — open the Claude App to connect."
    ;;
esac
