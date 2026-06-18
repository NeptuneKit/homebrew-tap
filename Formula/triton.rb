# typed: false
# frozen_string_literal: true

class Triton < Formula
  desc "DEBUG-only iOS app inspection and control CLI for AI agents"
  homepage "https://github.com/NeptuneKit/TritonKit"
  version "0.1.23"
  license :cannot_represent

  on_arm do
    url "https://github.com/NeptuneKit/TritonKit/releases/download/v0.1.23/triton-macos-arm64.tar.gz"
    sha256 "66e979bb3000c81c7cd3021eb05550def91bd939fddd28f8ba5b0efe1835798d"
  end

  on_intel do
    url "https://github.com/NeptuneKit/TritonKit/releases/download/v0.1.23/triton-macos-x86_64.tar.gz"
    sha256 "9d3cd72e92ad7f54f2c4f8bb848a045e5a70572f4a69da6a2f581cf1cac6d5c0"
  end

  depends_on :macos

  def install
    binary = Dir["triton-macos-*/triton"].first || Dir["triton"].first
    odie "triton binary not found in release archive" if binary.nil?

    web_dir = Dir["triton-macos-*/web"].first || Dir["web"].first
    odie "bundled web assets not found in release archive" if web_dir.nil?

    bin.install binary => "triton"
    pkgshare.install web_dir => "web"
  end

  test do
    require "json"

    assert_match version.to_s, shell_output("#{bin}/triton version")

    version_json = JSON.parse(shell_output("#{bin}/triton version --json"))
    assert_equal true, version_json["ok"]
    assert_equal version.to_s, version_json["version"]

    assert_path_exists pkgshare/"web/index.html"

    web_plan = JSON.parse(shell_output("#{bin}/triton web --print-command --json"))
    assert_equal true, web_plan["ok"]
    assert_equal "packaged", web_plan["mode"]
    assert_equal "#{pkgshare}/web", web_plan["bundledWebRoot"]
  end
end
