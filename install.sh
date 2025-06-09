#!/usr/bin/env bash
set -euo pipefail

# Default installation prefix
PREFIX="${PREFIX:-/usr/local}"
BIN_DIR="$PREFIX/bin"
SCRIPT_NAME="gbn"
REPO_URL="https://github.com/muneebshahid/gbn"
SCRIPT_URL="https://raw.githubusercontent.com/muneebshahid/gbn/main/gbn"

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[0;33m'
NC='\033[0m' # No Color

# Helper functions
info() {
    echo -e "${GREEN}[INFO]${NC} $1"
}

error() {
    echo -e "${RED}[ERROR]${NC} $1" >&2
}

warning() {
    echo -e "${YELLOW}[WARNING]${NC} $1"
}

# Detect if we're running from curl pipe
if [[ ! -t 0 ]] && [[ ! -f "$SCRIPT_NAME" ]]; then
    info "Detected pipe installation, downloading gbn..."
    TEMP_DIR=$(mktemp -d)
    trap "rm -rf $TEMP_DIR" EXIT

    cd "$TEMP_DIR"
    if ! curl -fsSL "$SCRIPT_URL" -o "$SCRIPT_NAME"; then
        error "Failed to download gbn from $SCRIPT_URL"
        exit 1
    fi
    chmod +x "$SCRIPT_NAME"
elif [[ ! -f "$SCRIPT_NAME" ]]; then
    error "Cannot find $SCRIPT_NAME in current directory"
    error "Try running: curl -sSL $REPO_URL/raw/main/install.sh | bash"
    exit 1
fi

# Check if zsh is installed
if ! command -v zsh >/dev/null 2>&1; then
    error "zsh is required but not installed. Please install zsh first."
    exit 1
fi

# Create bin directory if it doesn't exist
if [[ ! -d "$BIN_DIR" ]]; then
    info "Creating directory $BIN_DIR"
    mkdir -p "$BIN_DIR" || {
        error "Failed to create $BIN_DIR. You may need to run with sudo."
        exit 1
    }
fi

# Check write permissions
if [[ ! -w "$BIN_DIR" ]]; then
    error "No write permission to $BIN_DIR. Try running with sudo or set PREFIX to a writable location."
    echo "Example: PREFIX=\$HOME/.local ./install.sh"
    exit 1
fi

# Install the script
info "Installing $SCRIPT_NAME to $BIN_DIR"
cp "$SCRIPT_NAME" "$BIN_DIR/" || {
    error "Failed to copy $SCRIPT_NAME to $BIN_DIR"
    exit 1
}

# Make it executable
chmod +x "$BIN_DIR/$SCRIPT_NAME" || {
    error "Failed to make $BIN_DIR/$SCRIPT_NAME executable"
    exit 1
}

# Check if bin directory is in PATH
if [[ ":$PATH:" != *":$BIN_DIR:"* ]]; then
    warning "$BIN_DIR is not in your PATH"
    echo ""
    echo "Add the following line to your shell configuration file (~/.bashrc, ~/.zshrc, etc.):"
    echo "export PATH=\"$BIN_DIR:\$PATH\""
    echo ""
fi

# Check for optional dependencies
info "Checking dependencies..."
if command -v fzf >/dev/null 2>&1; then
    info "✓ fzf is installed (recommended)"
else
    warning "fzf is not installed. Install it for the best experience:"
    echo "  macOS:  brew install fzf"
    echo "  Linux:  Check your package manager or https://github.com/junegunn/fzf#installation"
fi

if command -v gum >/dev/null 2>&1; then
    info "✓ gum is installed (optional)"
else
    info "gum is not installed (optional). The script will work without it."
fi

echo ""
info "Installation complete! 🎉"
echo ""
echo "Usage: $SCRIPT_NAME [options]"
echo "Run '$SCRIPT_NAME --help' for more information."
