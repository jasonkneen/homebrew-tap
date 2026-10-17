class Dpty < Formula
  desc "Durable PTY (dpty): sessions that outlive your app, as a daemon, CLI and MCP server"
  homepage "https://jasonkneen.github.io/durable-pty/"
  license "MIT"
  version "0.1.0"

  on_macos do
    on_arm do
      url "https://github.com/jasonkneen/durable-pty/releases/download/v0.1.0/dpty-aarch64-apple-darwin.tar.gz"
      sha256 "f4d5389684d22a0057b286eee7a31c7ff486a6c8916ef090562cc7df2eff02e1"
    end
    on_intel do
      url "https://github.com/jasonkneen/durable-pty/releases/download/v0.1.0/dpty-x86_64-apple-darwin.tar.gz"
      sha256 "4ba97eef4aa9daa66212c717c53dab44c22719fabee1ecd8d4418e192488a47b"
    end
  end
  on_linux do
    on_arm do
      url "https://github.com/jasonkneen/durable-pty/releases/download/v0.1.0/dpty-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "d04216b5d9b675247d1517dac32d8ab269b87091ac56830ca302e5a9d848e02f"
    end
    on_intel do
      url "https://github.com/jasonkneen/durable-pty/releases/download/v0.1.0/dpty-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "24e02238c7f2b5533c086e6eaf99616e4a082ed9ae724aad5ddd07ad09bdaf79"
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
