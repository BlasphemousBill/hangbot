#!/bin/bash
# Serve the game so a phone on the same Wi-Fi can install it.
# Usage: ./serve.sh   (Ctrl-C to stop)

PORT="${1:-8080}"
DIR="$(cd "$(dirname "$0")" && pwd)"
IP=$(ipconfig getifaddr en0 2>/dev/null || ipconfig getifaddr en1 2>/dev/null || echo "127.0.0.1")

echo ""
echo "  HANGMAN is serving from: $DIR"
echo ""
echo "    On this Mac :  http://localhost:$PORT/"
echo "    On your phone:  http://$IP:$PORT/          <-- same Wi-Fi network"
echo ""
echo "  iPhone : open that address in Safari, tap Share, 'Add to Home Screen'"
echo "  Android: open in Chrome, tap the menu, 'Install app' / 'Add to Home screen'"
echo ""
echo "  Note: full offline mode needs https (see README). Over plain http on"
echo "  Wi-Fi the app installs and runs, but this server must stay running."
echo ""
echo "  Ctrl-C to stop."
echo ""

cd "$DIR" && python3 -m http.server "$PORT" --bind 0.0.0.0
