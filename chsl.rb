class Chsl < Formula
  desc "Experimental project aiming to recreate the functionality of FileOptimizer"
  homepage "https://github.com/Snesnopic/chisel"
  version "1.1.0"
  license "MIT"

  head "https://github.com/Snesnopic/chisel.git", branch: "main"

  depends_on "cmake" => :build
  depends_on "rust" => :build

  if OS.mac? && Hardware::CPU.arm?
    url "https://github.com/Snesnopic/chisel/releases/download/v1.1.0/chsl-macos-arm64.tar.gz"
    sha256 "9396cbf203ef964c955c16727e011d77c006e1b98d3d90614e22a55636e9cc56"
  elsif OS.mac? && Hardware::CPU.intel?
    url "https://github.com/Snesnopic/chisel/releases/download/v1.1.0/chsl-macos-x64.tar.gz"
    sha256 "723a26304b8cb4c44353f27067eef35b56a4127c9d67e165149cce39d64a94c7"
  elsif OS.linux? && Hardware::CPU.intel?
    url "https://github.com/Snesnopic/chisel/releases/download/v1.1.0/chsl-linux-x64-gcc.tar.gz"
    sha256 "a8ec51a67e0780dfe5d3989bc7069259a83187ccf67c183d111332383c8343d7"
  elsif OS.linux? && Hardware::CPU.arm?
    url "https://github.com/Snesnopic/chisel/releases/download/v1.1.0/chsl-linux-arm64.tar.gz"
    sha256 "2554361069111a170e11a5c66b7d503048d974d367b7a24de749bdffb331ffd9"
  end

  def install
    if build.head?
      system "cmake", "-S", ".", "-B", "build", *std_cmake_args
      system "cmake", "--build", "build", "--config", "Release"
      bin.install "build/bin/Release/chsl"
    else
      bin.install "chsl"
    end
  end

  test do
    assert_match "chisel", shell_output("#{bin}/chsl --help")
  end
end
