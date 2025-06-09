class Gbn < Formula
  desc "Interactive Git branch and commit navigator with rich previews"
  homepage "https://github.com/muneebshahid/gbn"
  url "https://github.com/muneebshahid/gbn/archive/refs/tags/v1.0.0.tar.gz"
  sha256 "PLACEHOLDER_SHA256"
  license "MIT"
  head "https://github.com/muneebshahid/gbn.git", branch: "main"

  depends_on "git"
  depends_on "fzf" => :recommended
  depends_on "gum" => :optional

  def install
    bin.install "gbn"
  end

  test do
    system "git", "init"
    system "git", "config", "user.email", "test@example.com"
    system "git", "config", "user.name", "Test User"
    system "git", "commit", "--allow-empty", "-m", "Initial commit"
    system "git", "checkout", "-b", "test-branch"
    system "git", "commit", "--allow-empty", "-m", "Test commit"

    assert_match "Usage:", shell_output("#{bin}/gbn --help")
  end
end
