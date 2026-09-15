# typed: false
# frozen_string_literal: true

class Triton < Formula
  desc "DEBUG-only iOS app inspection and control CLI for AI agents"
  homepage "https://github.com/NeptuneKit/TritonKit"
  version "0.2.22"
  license :cannot_represent

  on_arm do
    url "https://github.com/NeptuneKit/TritonKit/releases/download/v0.2.22/triton-macos-arm64.tar.gz"
    sha256 "f7aa09cd2b2ffd13884a10daed20586a47afb629893bdd5c0f6119314118f506"
  end

  on_intel do
    url "https://github.com/NeptuneKit/TritonKit/releases/download/v0.2.22/triton-macos-x86_64.tar.gz"
    sha256 "425e69793cd1e9ca2f2416f9369f6548fbcf0f87320cd7308609c39d00a0fda0"
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
