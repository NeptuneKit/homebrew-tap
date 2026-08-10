# typed: false
# frozen_string_literal: true

class Triton < Formula
  desc "DEBUG-only iOS app inspection and control CLI for AI agents"
  homepage "https://github.com/NeptuneKit/TritonKit"
  version "0.2.18"
  license :cannot_represent

  on_arm do
    url "https://github.com/NeptuneKit/TritonKit/releases/download/v0.2.18/triton-macos-arm64.tar.gz"
    sha256 "76a4442cc382c1bcdcb27e648555943b5e430c67c1d83789f24d2b21506f4fc7"
  end

  on_intel do
    url "https://github.com/NeptuneKit/TritonKit/releases/download/v0.2.18/triton-macos-x86_64.tar.gz"
    sha256 "ef5ec3e473988d0f44bf5448e8115ef06d26c3c92ffe54c495d5f2091129e288"
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
