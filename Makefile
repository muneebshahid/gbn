# Makefile for gbn installation

PREFIX ?= /usr/local
BINDIR = $(PREFIX)/bin
DOCDIR = $(PREFIX)/share/doc/gbn
LICENSEDIR = $(PREFIX)/share/licenses/gbn

# Default target
.PHONY: all
all:
	@echo "gbn - Git Branch Navigator"
	@echo ""
	@echo "Available targets:"
	@echo "  install    - Install gbn to $(PREFIX)"
	@echo "  uninstall  - Remove gbn from $(PREFIX)"
	@echo "  test       - Run basic tests"
	@echo "  clean      - Clean temporary files"
	@echo ""
	@echo "Use PREFIX=/path to change installation directory"
	@echo "Example: make install PREFIX=$$HOME/.local"

.PHONY: install
install:
	@echo "Installing gbn to $(BINDIR)..."
	@install -Dm755 gbn $(DESTDIR)$(BINDIR)/gbn
	@install -Dm644 README.md $(DESTDIR)$(DOCDIR)/README.md
	@install -Dm644 CHANGELOG.md $(DESTDIR)$(DOCDIR)/CHANGELOG.md
	@install -Dm644 LICENSE $(DESTDIR)$(LICENSEDIR)/LICENSE
	@echo "Installation complete!"
	@echo ""
	@if ! echo "$$PATH" | grep -q "$(BINDIR)"; then \
		echo "WARNING: $(BINDIR) is not in your PATH"; \
		echo "Add it with: export PATH=\"$(BINDIR):$$PATH\""; \
	fi

.PHONY: uninstall
uninstall:
	@echo "Removing gbn..."
	@rm -f $(DESTDIR)$(BINDIR)/gbn
	@rm -rf $(DESTDIR)$(DOCDIR)
	@rm -rf $(DESTDIR)$(LICENSEDIR)
	@echo "Uninstall complete!"

.PHONY: test
test:
	@echo "Running basic tests..."
	@bash -c 'if ! command -v zsh >/dev/null; then echo "ERROR: zsh is required"; exit 1; fi'
	@bash -c 'if ! command -v git >/dev/null; then echo "ERROR: git is required"; exit 1; fi'
	@./gbn --help >/dev/null && echo "✓ Help command works"
	@echo "Basic tests passed!"

.PHONY: clean
clean:
	@rm -rf packaging/*/build
	@rm -rf packaging/*/pkg
	@rm -rf packaging/*/src
	@rm -f packaging/*/*.tar.gz
	@echo "Cleaned temporary files"