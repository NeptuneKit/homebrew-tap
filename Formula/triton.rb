# typed: false
# frozen_string_literal: true

class Triton < Formula
  desc "DEBUG-only iOS app inspection and control CLI for AI agents"
  homepage "https://github.com/NeptuneKit/TritonKit"
  version "0.1.17"
  license :cannot_represent

  on_arm do
    url "https://github.com/NeptuneKit/TritonKit/releases/download/v0.1.17/triton-macos-arm64.tar.gz"
    sha256 "5113d801d3067fd20f1bb619b55a210d6ed81c2acc98760382380169d535b610"
  end

  on_intel do
    url "https://github.com/NeptuneKit/TritonKit/releases/download/v0.1.17/triton-macos-x86_64.tar.gz"
    sha256 "8863d11698e99feee91fd43ef5769d2606c2d1f681c0446fc2cd0339691c614e"
  end

  depends_on :macos

  def install
    binary = Dir["triton-macos-*/triton"].first || Dir["triton"].first
    odie "triton binary not found in release archive" if binary.nil?

    bin.install binary => "triton"
  end

  test do
    require "json"

    assert_match version.to_s, shell_output("#{bin}/triton version")

    version_json = JSON.parse(shell_output("#{bin}/triton version --json"))
    assert_equal true, version_json["ok"]
    assert_equal version.to_s, version_json["version"]
  end
end
