#!/usr/bin/env bash
set -Eeuo pipefail

# Forward SIGTERM/SIGINT to the main process
trap 'kill -TERM $child 2>/dev/null || true' TERM INT

main() {
  # Start the main process in background
  "$@" &
  child=$!

  # Wait until the app is ready (replace with your own check/port)
  until curl -fsS http://127.0.0.1:11434/ >/dev/null 2>&1; do
    sleep 1
  done

  # Run your one-time/init command (idempotent with a marker file)
  if [ ! -f /data/.init_done ]; then
    # EXAMPLE: your CLI here
    your-cli subcommand --flag || true
    touch /data/.init_done
  fi

  # Wait on the main process
  wait "$child"
}

main "$@"
