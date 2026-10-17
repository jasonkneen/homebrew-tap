class Dpty < Formula
  desc "Durable PTY (dpty): sessions that outlive your app, as a daemon, CLI and MCP server"
  homepage "https://jasonkneen.github.io/durable-pty/"
  license "MIT"
  version "0.1.1"

  on_macos do
    on_arm do
      url "https://github.com/jasonkneen/durable-pty/releases/download/v0.1.1/dpty-aarch64-apple-darwin.tar.gz"
      sha256 "acbac2be580f42ed4d2e7b6a24be15dfd883126ec84a30c3888470f7274b34fd"
    end
    on_intel do
      url "https://github.com/jasonkneen/durable-pty/releases/download/v0.1.1/dpty-x86_64-apple-darwin.tar.gz"
      sha256 "28a0b87fca02758581da2aee5a9ffecbe8eab3875eadf398314067f5ed2fb2ca"
    end
  end
  on_linux do
    on_arm do
      url "https://github.com/jasonkneen/durable-pty/releases/download/v0.1.1/dpty-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "8f8b48d56311d6ad64ac7e673161c4c2a8835f329d16810f1b4f0b0e40bcec5c"
    end
    on_intel do
      url "https://github.com/jasonkneen/durable-pty/releases/download/v0.1.1/dpty-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "1d796e230cb71e70adb9af8619d05e9424e34208810d15004211b6b034fbb416"
    end
  end

  def install
    bin.install "dpty"
  end

  # `brew services start dpty` runs the daemon at login. `dpty install` does the same without Homebrew.
  service do
    run [opt_bin/"dpty", "serve"]
    keep_alive true
    log_path var/"log/dpty.log"
    error_log_path var/"log/dpty.log"
    environment_variables PATH: std_service_path_env
  end

  test do
    assert_match "dpty", shell_output("#{bin}/dpty --version")
    assert_match "not running", shell_output("DPTY_HOME=#{testpath}/home #{bin}/dpty status", 3)
  end
end
