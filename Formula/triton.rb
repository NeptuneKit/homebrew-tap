# typed: false
# frozen_string_literal: true

class Triton < Formula
  desc "DEBUG-only iOS app inspection and control CLI for AI agents"
  homepage "https://github.com/NeptuneKit/TritonKit"
  version "0.1.2"
  license :cannot_represent

  on_arm do
    url "https://github.com/NeptuneKit/TritonKit/releases/download/v0.1.2/triton-macos-arm64.tar.gz"
    sha256 "33ce77cb9ae6fc5452e8ef0c1cc82a980403d2588018aec1a56c52fa0a509aa7"
  end

  on_intel do
    url "https://github.com/NeptuneKit/TritonKit/releases/download/v0.1.2/triton-macos-x86_64.tar.gz"
    sha256 "c14ed09c1b3ffb1bc125e50ab36bfcdebf1bcfc4a6bbb468f1afcc2d27c49eda"
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
