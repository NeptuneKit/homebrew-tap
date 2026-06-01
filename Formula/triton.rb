# typed: false
# frozen_string_literal: true

class Triton < Formula
  desc "DEBUG-only iOS app inspection and control CLI for AI agents"
  homepage "https://github.com/NeptuneKit/TritonKit"
  version "0.1.14"
  license :cannot_represent

  on_arm do
    url "https://github.com/NeptuneKit/TritonKit/releases/download/v0.1.14/triton-macos-arm64.tar.gz"
    sha256 "76909878d0d1fab8905f64f0e83866ec7a19fda53eede933f71bb0986542c73b"
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
