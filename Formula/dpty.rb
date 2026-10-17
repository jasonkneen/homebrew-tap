class Dpty < Formula
  desc "Durable PTY (dpty): sessions that outlive your app, as a daemon, CLI and MCP server"
  homepage "https://jasonkneen.github.io/durable-pty/"
  license "MIT"
  # No release has been cut yet: install the development version with `brew install --HEAD jasonkneen/tap/dpty`.
  # The release workflow replaces this file with a versioned formula.
  head "https://github.com/jasonkneen/durable-pty.git", branch: "main"

  depends_on "rust" => :build

  def install
    system "cargo", "install", *std_cargo_args
  end

  service do
    run [opt_bin/"dpty", "serve"]
    keep_alive true
    log_path var/"log/dpty.log"
    error_log_path var/"log/dpty.log"
    environment_variables PATH: std_service_path_env
  end

  test do
    assert_match "dpty", shell_output("#{bin}/dpty --version")
  end
end
