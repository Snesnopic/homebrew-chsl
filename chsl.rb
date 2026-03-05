class Chsl < Formula
  desc "Experimental project aiming to recreate the functionality of FileOptimizer"
  homepage "https://github.com/Snesnopic/chisel"
  version "1.2.0"
  license "MIT"

  head "https://github.com/Snesnopic/chisel.git", branch: "main"

  depends_on "cmake" => :build
  depends_on "rust" => :build

  if OS.mac? && Hardware::CPU.arm?
    url "https://github.com/Snesnopic/chisel/releases/download/v1.2.0/chsl-macos-arm64.tar.gz"
    sha256 "2e4eb72ba7733cab9b5f80f7a9171c9dafaa71c0472085beae9186c5c1794722"
  elsif OS.mac? && Hardware::CPU.intel?
    url "https://github.com/Snesnopic/chisel/releases/download/v1.2.0/chsl-macos-x64.tar.gz"
    sha256 "b9326df5a2b5bc8de150c1e666aa527da2e2b680123d8cd42edb149d25a76fa1"
  elsif OS.linux? && Hardware::CPU.intel?
    url "https://github.com/Snesnopic/chisel/releases/download/v1.2.0/chsl-linux-x64-gcc.tar.gz"
    sha256 "c775548420e2bde1759d0386caef5bbbec60e000ed1dd2f3a8af0501e86b7d7f"
  elsif OS.linux? && Hardware::CPU.arm?
    url "https://github.com/Snesnopic/chisel/releases/download/v1.2.0/chsl-linux-arm64.tar.gz"
    sha256 "c67b90a4409dd7286d81228fae7892f8c6a30b6a823dcf02ffd2fe606313f39f"
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
