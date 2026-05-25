# typed: false
# frozen_string_literal: true

class Triton < Formula
  desc "DEBUG-only iOS app inspection and control CLI for AI agents"
  homepage "https://github.com/NeptuneKit/TritonKit"
  version "0.1.9"
  license :cannot_represent

  on_arm do
    url "https://github.com/NeptuneKit/TritonKit/releases/download/v0.1.9/triton-macos-arm64.tar.gz"
    sha256 "dcb33d610af59e96aaa679367fb417862c5bf0cfa31c8cbb60077f6b7affca31"
  end

  on_intel do
    url "https://github.com/NeptuneKit/TritonKit/releases/download/v0.1.9/triton-macos-x86_64.tar.gz"
    sha256 "bf4722a0c8ed379c028990da18d435d58e1eebf12163a7141a457c42fa26984a"
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
