#!/usr/bin/env bash
# Script to help build packages for various distributions

set -euo pipefail

VERSION="1.0.0"
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
PROJECT_ROOT="$(dirname "$SCRIPT_DIR")"

echo "gbn Package Builder v$VERSION"
echo "=========================="
echo ""

usage() {
    cat <<EOF
Usage: $0 [OPTION]

Options:
  aur       Build AUR package
  deb       Build Debian/Ubuntu package
  rpm       Build RPM package for Fedora/RHEL
  all       Build all packages
  help      Show this help

Example:
  $0 aur     # Build AUR package
  $0 all     # Build all packages
EOF
}

build_aur() {
    echo "Building AUR package..."
    cd "$SCRIPT_DIR/aur"
    makepkg -sf
    echo "AUR package built successfully!"
    echo "Package location: $SCRIPT_DIR/aur/*.pkg.tar.*"
}

build_deb() {
    echo "Building Debian package..."
    cd "$PROJECT_ROOT"
    
    # Create temporary build directory
    BUILD_DIR=$(mktemp -d)
    trap "rm -rf $BUILD_DIR" EXIT
    
    # Copy files
    cp -r . "$BUILD_DIR/gbn-$VERSION"
    cd "$BUILD_DIR/gbn-$VERSION"
    
    # Copy debian directory
    cp -r "$SCRIPT_DIR/debian" debian
    
    # Build package
    dpkg-buildpackage -us -uc -b
    
    # Copy built packages back
    cp ../*.deb "$SCRIPT_DIR/"
    
    echo "Debian package built successfully!"
    echo "Package location: $SCRIPT_DIR/*.deb"
}

build_rpm() {
    echo "Building RPM package..."
    
    # Setup RPM build tree
    mkdir -p ~/rpmbuild/{BUILD,RPMS,SOURCES,SPECS,SRPMS}
    
    # Create source tarball
    cd "$PROJECT_ROOT/.."
    tar czf ~/rpmbuild/SOURCES/gbn-$VERSION.tar.gz --exclude=.git gbn
    
    # Copy spec file
    cp "$SCRIPT_DIR/rpm/gbn.spec" ~/rpmbuild/SPECS/
    
    # Build RPM
    rpmbuild -ba ~/rpmbuild/SPECS/gbn.spec
    
    # Copy built packages
    cp ~/rpmbuild/RPMS/noarch/*.rpm "$SCRIPT_DIR/"
    cp ~/rpmbuild/SRPMS/*.rpm "$SCRIPT_DIR/"
    
    echo "RPM package built successfully!"
    echo "Package location: $SCRIPT_DIR/*.rpm"
}

case "${1:-help}" in
    aur)
        build_aur
        ;;
    deb)
        build_deb
        ;;
    rpm)
        build_rpm
        ;;
    all)
        build_aur
        echo ""
        build_deb
        echo ""
        build_rpm
        ;;
    help|*)
        usage
        ;;
esac