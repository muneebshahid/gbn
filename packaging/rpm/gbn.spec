Name:           gbn
Version:        1.0.0
Release:        1%{?dist}
Summary:        Interactive Git branch and commit navigator with rich previews

License:        MIT
URL:            https://github.com/muneebshahid/gbn
Source0:        %{url}/archive/v%{version}/%{name}-%{version}.tar.gz

BuildArch:      noarch
Requires:       git
Requires:       zsh
Recommends:     fzf
Suggests:       gum

%description
gbn (Git Branch Navigator) is a powerful interactive tool for switching
between Git branches and commits with rich previews. It provides an
intuitive interface using fzf, gum, or a pure shell fallback.

Features include:
- Interactive branch switching with real-time preview
- Commit navigation with history browsing
- Branch status indicators
- Rich previews with diffs and file changes
- Multiple interface options

%prep
%autosetup

%build
# Nothing to build

%install
install -Dm755 gbn %{buildroot}%{_bindir}/gbn
install -Dm644 README.md %{buildroot}%{_docdir}/%{name}/README.md
install -Dm644 CHANGELOG.md %{buildroot}%{_docdir}/%{name}/CHANGELOG.md
install -Dm644 LICENSE %{buildroot}%{_licensedir}/%{name}/LICENSE

%files
%{_bindir}/gbn
%doc %{_docdir}/%{name}/README.md
%doc %{_docdir}/%{name}/CHANGELOG.md
%license %{_licensedir}/%{name}/LICENSE

%changelog
* Mon Jan 06 2025 Muneeb Shahid <muneebshahid5@gmail.com> - 1.0.0-1
- Initial package release
