class Dpty < Formula
  desc "Durable PTY (dpty): sessions that outlive your app, as a daemon, CLI and MCP server"
  homepage "https://jasonkneen.github.io/durable-pty/"
  license "MIT"
  version "0.1.2"

  on_macos do
    on_arm do
      url "https://github.com/jasonkneen/durable-pty/releases/download/v0.1.2/dpty-aarch64-apple-darwin.tar.gz"
      sha256 "d28d923d4f0b39840322a8e8bbc2cededa1af5f77041074bb22025a9e20105c5"
    end
    on_intel do
      url "https://github.com/jasonkneen/durable-pty/releases/download/v0.1.2/dpty-x86_64-apple-darwin.tar.gz"
      sha256 "55b98a4717db3675424a9fa88665a6edab32b66de6ea60078dd051c622c99aca"
    end
  end
  on_linux do
    on_arm do
      url "https://github.com/jasonkneen/durable-pty/releases/download/v0.1.2/dpty-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "c1ce7968b46e73fb3a033aae8e623d72b4301761f5c81f4845c7884095b1d416"
    end
    on_intel do
      url "https://github.com/jasonkneen/durable-pty/releases/download/v0.1.2/dpty-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "a4b9ea09532b59399485f4b8d4d77e2d30fec558a20e1040ab5f5e65df2050ed"
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
