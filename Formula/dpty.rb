class Dpty < Formula
  desc "Durable PTY (dpty): sessions that outlive your app, as a daemon, CLI and MCP server"
  homepage "https://jasonkneen.github.io/durable-pty/"
  license "MIT"
  version "0.1.0"
  url "ssh://git@github.com/jasonkneen/durable-pty.git", tag: "v0.1.0", revision: "cabc2b18170d0901e78b9c8b7ac03cb199f1ad18"
  head "ssh://git@github.com/jasonkneen/durable-pty.git", branch: "main"

  depends_on "rust" => :build

  def install
    system "cargo", "install", *std_cargo_args
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
