class Chsl < Formula
  desc "Experimental project aiming to recreate the functionality of FileOptimizer"
  homepage "https://github.com/Snesnopic/chisel"
  version "1.3.0"
  license "MIT"

  head "https://github.com/Snesnopic/chisel.git", branch: "main"

  depends_on "cmake" => :build
  depends_on "rust" => :build

  if OS.mac? && Hardware::CPU.arm?
    url "https://github.com/Snesnopic/chisel/releases/download/v1.3.0/chsl-macos-arm64.tar.gz"
    sha256 "a5474bff38233938b327d068e8fa10054ba83ffff5b585b97d897aa24f632ffc"
  elsif OS.mac? && Hardware::CPU.intel?
    url "https://github.com/Snesnopic/chisel/releases/download/v1.3.0/chsl-macos-x64.tar.gz"
    sha256 "f38c116e05964f0e77370978f5bcf19f3522fb9f1851b64eb5b0cf6e276a0ca7"
  elsif OS.linux? && Hardware::CPU.intel?
    url "https://github.com/Snesnopic/chisel/releases/download/v1.3.0/chsl-linux-x64-gcc.tar.gz"
    sha256 "2af97ae7efb307dbb8c43d41eab8301f032237ca0834907221315db10d529a89"
  elsif OS.linux? && Hardware::CPU.arm?
    url "https://github.com/Snesnopic/chisel/releases/download/v1.3.0/chsl-linux-arm64.tar.gz"
    sha256 "f9fc0aefbb99dfa7f67b6d772d1274aa50c1cfcf8b8facdb0edc4d9808f49246"
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
