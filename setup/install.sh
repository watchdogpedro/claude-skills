#!/bin/bash
# One-command Claude Code setup for Paul Denman
# Run: curl -fsSL https://raw.githubusercontent.com/watchdogpedro/claude-skills/main/setup/install.sh | bash

set -e

REPO="watchdogpedro/claude-skills"
RAW="https://raw.githubusercontent.com/$REPO/main"

echo ""
echo "Claude Code Setup"
echo "================================"
echo ""

# Check dependencies
check_cmd() {
  if ! command -v "$1" &>/dev/null; then
    echo "ERROR: '$1' not found. Install it first:"
    if [ "$1" = "claude" ]; then
      echo "  https://claude.ai/code"
    elif [ "$1" = "gh" ]; then
      echo "  brew install gh"
      echo "  gh auth login"
    fi
    exit 1
  fi
  echo "  Found: $1"
}

echo "Checking dependencies..."
check_cmd claude
check_cmd gh
echo ""

# Create directories
mkdir -p ~/.local/bin
mkdir -p ~/.claude

# Install claude-go script
echo "Installing claude-go..."
curl -fsSL "$RAW/setup/claude-go" -o ~/.local/bin/claude-go
chmod +x ~/.local/bin/claude-go
echo "  Installed: ~/.local/bin/claude-go"
echo ""

# Install personal rules (never overwrite if already customised)
if [ ! -f ~/.claude/CLAUDE-personal-rules.md ]; then
  echo "Installing CLAUDE-personal-rules.md..."
  curl -fsSL "$RAW/setup/CLAUDE-personal-rules.md" -o ~/.claude/CLAUDE-personal-rules.md
  echo "  Installed: ~/.claude/CLAUDE-personal-rules.md"
else
  echo "  Skipping CLAUDE-personal-rules.md (already exists — won't overwrite your customisations)"
fi
echo ""

# Add ~/.local/bin to PATH if not already there
if [[ ":$PATH:" != *":$HOME/.local/bin:"* ]]; then
  SHELL_RC=""
  if [ -f ~/.zshrc ]; then
    SHELL_RC=~/.zshrc
  elif [ -f ~/.bashrc ]; then
    SHELL_RC=~/.bashrc
  fi

  if [ -n "$SHELL_RC" ]; then
    echo "" >> "$SHELL_RC"
    echo "# Add ~/.local/bin to PATH (for claude-go)" >> "$SHELL_RC"
    echo 'export PATH="$HOME/.local/bin:$PATH"' >> "$SHELL_RC"
    echo "  Added ~/.local/bin to PATH in $SHELL_RC"
    echo "  ACTION NEEDED: Run 'source $SHELL_RC' or open a new terminal"
  fi
else
  echo "  PATH already includes ~/.local/bin"
fi

echo ""
echo "================================"
echo "Done! Run: claude-go"
echo ""
echo "Skills auto-loaded from: github.com/$REPO"
echo ""
