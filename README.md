# gbn - Git Branch Navigator

[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](https://opensource.org/licenses/MIT)

A powerful interactive Git branch and commit switcher with rich previews. Navigate your Git history with ease using `fzf`, `gum`, or a pure shell interface.

![gbn demo](https://github.com/user-attachments/assets/gbn-demo.gif)

## Features

- **Interactive branch switching** with real-time preview
- **Commit navigation** - browse and checkout recent commits
- **Branch status indicators** showing sync status with upstream
- **Rich previews** including commit history, file changes, and diffs
- **Multiple interfaces**: Uses `fzf` for the best experience, falls back to `gum` or pure shell
- **Performance optimized** for large repositories
- **Remote branch support** with `-r/--remote` flag

### Status Indicators

- `✓` - Branch is synced with upstream
- `↑N` - Branch is N commits ahead of upstream
- `↓N` - Branch is N commits behind upstream
- `↑N ↓M` - Branch has diverged (N ahead, M behind)
- `○` - Branch has no upstream tracking

## Installation

### Quick Install (Recommended)

```bash
# Install to /usr/local/bin (requires sudo)
curl -sSL https://raw.githubusercontent.com/muneebshahid/gbn/main/install.sh | sudo bash

# Or install to user directory (no sudo required)
curl -sSL https://raw.githubusercontent.com/muneebshahid/gbn/main/install.sh | PREFIX=$HOME/.local bash
```

### Package Managers

#### Homebrew (macOS/Linux)

```bash
brew tap muneebshahid/gbn
brew install gbn
```

#### Arch Linux (AUR)

```bash
# Using yay
yay -S gbn

# Using paru
paru -S gbn

# Manual from AUR
git clone https://aur.archlinux.org/gbn.git
cd gbn
makepkg -si
```

#### Ubuntu/Debian (via PPA)

```bash
# Add PPA repository
sudo add-apt-repository ppa:muneebshahid/gbn
sudo apt update
sudo apt install gbn
```

#### Fedora/RHEL (via COPR)

```bash
sudo dnf copr enable muneebshahid/gbn
sudo dnf install gbn
```

### Manual Installation

#### From Release

```bash
# Download latest release
curl -LO https://github.com/muneebshahid/gbn/releases/latest/download/gbn-v1.0.0.tar.gz

# Extract
tar xzf gbn-v1.0.0.tar.gz
cd gbn-v1.0.0

# Install
sudo ./install.sh
```

#### From Source

```bash
# Clone the repository
git clone https://github.com/muneebshahid/gbn.git
cd gbn

# Using make (recommended)
sudo make install              # Install to /usr/local
make install PREFIX=$HOME/.local  # Install to user directory

# Using install script
sudo ./install.sh              # Install to /usr/local
PREFIX=$HOME/.local ./install.sh  # Install to user directory
```

#### Direct Script Download

```bash
# Download just the script
sudo curl -L https://raw.githubusercontent.com/muneebshahid/gbn/main/gbn -o /usr/local/bin/gbn
sudo chmod +x /usr/local/bin/gbn

# Or to user directory
mkdir -p $HOME/.local/bin
curl -L https://raw.githubusercontent.com/muneebshahid/gbn/main/gbn -o $HOME/.local/bin/gbn
chmod +x $HOME/.local/bin/gbn
```

### Verification

After installation, verify it's working:

```bash
gbn --help
```

## Usage

```bash
# Basic usage - shows local branches and recent commits
gbn

# Include remote branches
gbn -r
gbn --remote

# Adjust preview settings
gbn -n 20           # Show 20 commits in preview
gbn -w 60           # Set preview width to 60%
gbn -l 100          # Show last 100 commits

# Combine options
gbn -r -n 30 -w 70
```

### Options

```
-n, --log-lines N       Number of commits to show in fzf preview (default: 15)
-w, --preview-width N   Preview pane width in percent (default: 50)
-r, --remote           Include remote branches
-l, --limit N          Number of commits to show (default: 50)
-h, --help             Show help and exit
```

## Requirements

- **Git** (required)
- **Zsh** (required - script uses zsh-specific features)
- **fzf** (recommended) - provides the richest interface with previews
- **gum** (optional) - fallback option with filtering
- Works without fzf/gum using pure shell interface

### Installing Dependencies

```bash
# macOS
brew install fzf gum

# Linux (with Homebrew)
brew install fzf gum

# Ubuntu/Debian
sudo apt install fzf
# For gum, see: https://github.com/charmbracelet/gum#installation

# Arch
sudo pacman -S fzf
# Install gum from AUR
```

## How It Works

1. **With fzf** (best experience):
   - Full preview of branches/commits with syntax highlighting
   - Shows commit history, file changes, and diffs
   - Real-time filtering and navigation

2. **With gum** (good experience):
   - Clean filtering interface
   - Simple branch selection

3. **Pure shell** (always works):
   - Arrow key navigation
   - Works in minimal environments

## Contributing

Contributions are welcome! Please feel free to submit a Pull Request. See [CONTRIBUTING.md](CONTRIBUTING.md) for guidelines.

### Packaging

The `packaging/` directory contains files for building distribution packages:
- `aur/` - Arch Linux AUR package files
- `debian/` - Debian/Ubuntu package files
- `rpm/` - Fedora/RHEL RPM spec file
- `build-packages.sh` - Helper script to build packages

To build packages, use: `./packaging/build-packages.sh [aur|deb|rpm|all]`

## License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.

## Author

Created by [Muneeb Shahid](https://github.com/muneebshahid)

## Acknowledgments

- Inspired by various Git workflow tools
- Built with [fzf](https://github.com/junegunn/fzf) and [gum](https://github.com/charmbracelet/gum)
