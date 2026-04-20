class Chsl < Formula
  desc "Experimental project aiming to recreate the functionality of FileOptimizer"
  homepage "https://github.com/Snesnopic/chisel"
  version "1.4.2"
  license "MIT"

  head "https://github.com/Snesnopic/chisel.git", branch: "main"

  depends_on "cmake" => :build
  depends_on "rust" => :build

  if OS.mac? && Hardware::CPU.arm?
    url "https://github.com/Snesnopic/chisel/releases/download/v1.4.2/chsl-macos-arm64.tar.gz"
    sha256 "67c160f1023deca3bd473c13e10c9b0d5d4fdc162b5f731a710288b49f7d7728"
  elsif OS.mac? && Hardware::CPU.intel?
    url "https://github.com/Snesnopic/chisel/releases/download/v1.4.2/chsl-macos-x64.tar.gz"
    sha256 "1510ac489c491481973ed5796511a596f55f453c6a119b353e7d7d049a4878b3"
  elsif OS.linux? && Hardware::CPU.intel?
    url "https://github.com/Snesnopic/chisel/releases/download/v1.4.2/chsl-linux-x64-gcc.tar.gz"
    sha256 "d9a4581addb75bd8328671047597f5c405a38f68ac1d33bbff0501093f6eb455"
  elsif OS.linux? && Hardware::CPU.arm?
    url "https://github.com/Snesnopic/chisel/releases/download/v1.4.2/chsl-linux-arm64.tar.gz"
    sha256 "9171c1afa11f14fd2772364d949b8e5c44f2609ffe8529c74bb8503a38c77474"
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
