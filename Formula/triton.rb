# typed: false
# frozen_string_literal: true

class Triton < Formula
  desc "DEBUG-only iOS app inspection and control CLI for AI agents"
  homepage "https://github.com/NeptuneKit/TritonKit"
  version "0.1.7"
  license :cannot_represent

  on_arm do
    url "https://github.com/NeptuneKit/TritonKit/releases/download/v0.1.7/triton-macos-arm64.tar.gz"
    sha256 "45b2ad06739b2df4101298acb855774ce074a749d9c8e23a747b46c6385212f7"
  end

  on_intel do
    url "https://github.com/NeptuneKit/TritonKit/releases/download/v0.1.7/triton-macos-x86_64.tar.gz"
    sha256 "d4d2ff4839a780c9c7fefefc447ea07ab9f893bfae1acf248945c139a97a7ff9"
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
