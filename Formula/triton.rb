# typed: false
# frozen_string_literal: true

class Triton < Formula
  desc "DEBUG-only iOS app inspection and control CLI for AI agents"
  homepage "https://github.com/NeptuneKit/TritonKit"
  version "0.1.0"
  license :cannot_represent

  on_arm do
    url "https://github.com/NeptuneKit/TritonKit/releases/download/v0.1.0/triton-macos-arm64.tar.gz"
    sha256 "5a813d2b71378e2ea5bf1bcad13d8fa398bd8d3234158e96bfafa6d7a705fae4"
  end

  on_intel do
    url "https://github.com/NeptuneKit/TritonKit/releases/download/v0.1.0/triton-macos-x86_64.tar.gz"
    sha256 "b001f4ef30b6464c408b80e5347a4df3b1ca94732192bebec568baeea60f5238"
  end

  depends_on :macos

  def install
    binary = Dir["triton-macos-*/triton"].first
    odie "triton binary not found in release archive" if binary.nil?

    bin.install binary => "triton"
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/triton version")
    assert_match '"ok":true', shell_output("#{bin}/triton version --json")
  end
end
