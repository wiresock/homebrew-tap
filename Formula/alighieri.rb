class Alighieri < Formula
  desc "Lightweight SOCKS5 proxy with Dante-inspired configuration"
  homepage "https://github.com/wiresock/alighieri"
  url "https://github.com/wiresock/alighieri/archive/refs/tags/v0.7.0.tar.gz"
  sha256 "0f1579a192ff506fe1cef2de7f2ab32348c896c01db11e080768b6358bb1f98b"
  license "AGPL-3.0-or-later"
  head "https://github.com/wiresock/alighieri.git", branch: "main"

  # Published GitHub releases only: a pushed tag whose release is still a
  # draft (or a prerelease) must not be reported as the stable version.
  livecheck do
    url :stable
    strategy :github_latest
  end

  depends_on "rust" => :build

  deny_network_access!

  # Resolve the locked dependency graph while network access is allowed, so
  # the build itself runs offline.
  def fetch
    system "cargo", "fetch", "--locked", "--target", "host-tuple"
  end

  def install
    system "cargo", "install", "--bin", "alighieri", *std_cargo_args
    etc.install "doc/alighieri.conf"
  end

  def caveats
    <<~EOS
      Stable releases come from the official WireSock tap:
        brew install wiresock/tap/alighieri

      Default config:
        #{etc}/alighieri.conf

      `brew services start alighieri` runs a per-user service with that
      config (example loopback listener 127.0.0.1:1080). After editing it,
      apply changes with `brew services restart alighieri`.

      The hardened public-TLS LaunchDaemon (dedicated _alighieri account
      under /opt/alighieri) is a separate deployment that Homebrew does not
      manage. See:
        https://github.com/wiresock/alighieri#privileged-public-tls-launchdaemon
    EOS
  end

  service do
    run [opt_bin/"alighieri", "--config", etc/"alighieri.conf"]
    keep_alive true
    working_dir var
    log_path var/"log/alighieri.log"
    error_log_path var/"log/alighieri.log"
  end

  test do
    output = shell_output("#{bin}/alighieri --version")
    assert_match(/^alighieri /, output)
    system bin/"alighieri", "--check", "--config", etc/"alighieri.conf"
  end
end
