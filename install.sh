#!/bin/bash
# curl -fsSL https://raw.githubusercontent.com/DennisEntwine/lidawake/main/install.sh | bash
set -euo pipefail
RAW="https://raw.githubusercontent.com/${REPO:-DennisEntwine/lidawake}/main"
DIR="$HOME/.swiftbar"

command -v brew >/dev/null || { echo "Needs Homebrew: https://brew.sh" >&2; exit 1; }
[ -d /Applications/SwiftBar.app ] || brew install --cask swiftbar

mkdir -p "$DIR"
curl -fsSL "$RAW/lidawake.10s.sh" -o "$DIR/.lidawake.tmp"
chmod +x "$DIR/.lidawake.tmp"
mv -f "$DIR/.lidawake.tmp" "$DIR/lidawake.10s.sh"
# Only set SwiftBar's plugin folder if the user hasn't picked one already.
defaults read com.ameba.SwiftBar PluginDirectory >/dev/null 2>&1 || defaults write com.ameba.SwiftBar PluginDirectory "$DIR"
PLUGINS=$(defaults read com.ameba.SwiftBar PluginDirectory)
[ "$PLUGINS" = "$DIR" ] || { mkdir -p "$PLUGINS"; ln -sf "$DIR/lidawake.10s.sh" "$PLUGINS/lidawake.10s.sh"; }

# Passwordless sudo for exactly these two commands, nothing else.
echo "Asking for your password once, to allow toggling without it from now on."
tmp=$(mktemp)
printf '%s ALL=(root) NOPASSWD: /usr/bin/pmset -a disablesleep 0, /usr/bin/pmset -a disablesleep 1\n' "$USER" > "$tmp"
sudo visudo -cf "$tmp" >/dev/null
sudo install -m 0440 -o root -g wheel "$tmp" /etc/sudoers.d/lidawake
rm -f "$tmp"
sudo mkdir -p /usr/local/bin && sudo ln -sf "$DIR/lidawake.10s.sh" /usr/local/bin/lidawake

open -a SwiftBar
echo "Done. Menu bar: moon = normal, sun = stays awake with lid closed. CLI: lidawake toggle"
