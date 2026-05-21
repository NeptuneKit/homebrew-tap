# typed: false
# frozen_string_literal: true

class Triton < Formula
  desc "DEBUG-only iOS app inspection and control CLI for AI agents"
  homepage "https://github.com/NeptuneKit/TritonKit"
  version "0.1.1"
  license :cannot_represent

  on_arm do
    url "https://github.com/NeptuneKit/TritonKit/releases/download/v0.1.1/triton-macos-arm64.tar.gz"
    sha256 "21035bb76f0fc3fafb9ea22326d35d3c8e50fdb611864f1ca6c1fe0b67a09b6f"
  end

  on_intel do
    url "https://github.com/NeptuneKit/TritonKit/releases/download/v0.1.1/triton-macos-x86_64.tar.gz"
    sha256 "55b63b727ce2ffd78c43f59c422aa4784ef98691dbfa229bb1cd429fa08d9a84"
  end

  depends_on :macos

  def install
    binary = Dir["triton-macos-*/triton"].first || Dir["triton"].first
    odie "triton binary not found in release archive" if binary.nil?

    bin.install binary => "triton"
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/triton version")
    assert_match '"ok":true', shell_output("#{bin}/triton version --json")
  end
end
