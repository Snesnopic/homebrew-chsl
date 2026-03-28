class Chsl < Formula
  desc "Experimental project aiming to recreate the functionality of FileOptimizer"
  homepage "https://github.com/Snesnopic/chisel"
  version "1.4.0"
  license "MIT"

  head "https://github.com/Snesnopic/chisel.git", branch: "main"

  depends_on "cmake" => :build
  depends_on "rust" => :build

  if OS.mac? && Hardware::CPU.arm?
    url "https://github.com/Snesnopic/chisel/releases/download/v1.4.0/chsl-macos-arm64.tar.gz"
    sha256 "fc0fe2514809108d1c79a2576e2c57e69e26d2272c9b7537782d99cc89c76d81"
  elsif OS.mac? && Hardware::CPU.intel?
    url "https://github.com/Snesnopic/chisel/releases/download/v1.4.0/chsl-macos-x64.tar.gz"
    sha256 "10eefa63763241b350d2cb68aebc9f135e42f7d7b369360b10881b25d420cfe9"
  elsif OS.linux? && Hardware::CPU.intel?
    url "https://github.com/Snesnopic/chisel/releases/download/v1.4.0/chsl-linux-x64-gcc.tar.gz"
    sha256 "a4c0794be3ac799f4443ac8eff4ef093da3815aa7904ad5bfa8411d645cbf5eb"
  elsif OS.linux? && Hardware::CPU.arm?
    url "https://github.com/Snesnopic/chisel/releases/download/v1.4.0/chsl-linux-arm64.tar.gz"
    sha256 "a728326f1ec05adf88d692b01d3c5d10bdf1ded4c4b8431d59f57082c1179244"
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
