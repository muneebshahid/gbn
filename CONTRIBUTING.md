# Contributing to gbn

Thank you for your interest in contributing to gbn! We welcome contributions from the community.

## How to Contribute

### Reporting Issues

- Check if the issue already exists in the [issue tracker](https://github.com/muneebshahid/gbn/issues)
- Include your system information (OS, shell version, git version)
- Provide steps to reproduce the issue
- Include any error messages or unexpected behavior

### Submitting Pull Requests

1. Fork the repository
2. Create a new branch for your feature (`git checkout -b feature/amazing-feature`)
3. Make your changes
4. Test your changes thoroughly
5. Commit your changes (`git commit -m 'Add amazing feature'`)
6. Push to your branch (`git push origin feature/amazing-feature`)
7. Open a Pull Request

### Development Guidelines

- Maintain compatibility with zsh
- Ensure the script works without fzf/gum (pure shell fallback)
- Test with both local and remote branches
- Follow the existing code style
- Add comments for complex logic
- Update documentation if needed

### Testing

Before submitting a PR, please test:

1. Basic functionality without fzf/gum
2. Full functionality with fzf
3. Functionality with gum (if available)
4. Remote branch handling (`-r` flag)
5. All command-line options
6. Performance with repositories of various sizes

### Code Style

- Use 2 spaces for indentation
- Keep lines under 100 characters when possible
- Use meaningful variable names
- Add error handling for edge cases
- Maintain POSIX compatibility where possible (except for zsh-specific features)

## Questions?

Feel free to open an issue for any questions about contributing.
