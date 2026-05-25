# typed: false
# frozen_string_literal: true

class Triton < Formula
  desc "DEBUG-only iOS app inspection and control CLI for AI agents"
  homepage "https://github.com/NeptuneKit/TritonKit"
  version "0.1.8"
  license :cannot_represent

  on_arm do
    url "https://github.com/NeptuneKit/TritonKit/releases/download/v0.1.8/triton-macos-arm64.tar.gz"
    sha256 "3f98d8317ba3b6cb49ee6fc8da0432337a241eccd909d0da4d9a76f8ac89b5eb"
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
