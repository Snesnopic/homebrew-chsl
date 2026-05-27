class Chsl < Formula
  desc "Experimental project aiming to recreate the functionality of FileOptimizer"
  homepage "https://github.com/Snesnopic/chisel"
  version "1.5.0"
  license "MIT"

  head "https://github.com/Snesnopic/chisel.git", branch: "main"

  depends_on "cmake" => :build
  depends_on "rust" => :build

  if OS.mac? && Hardware::CPU.arm?
    url "https://github.com/Snesnopic/chisel/releases/download/v1.5.0/chsl-macos-arm64.tar.gz"
    sha256 "4e08342b8590a2042258b08108fa3a0f405337412d958b5fa8a454427109b555"
  elsif OS.mac? && Hardware::CPU.intel?
    url "https://github.com/Snesnopic/chisel/releases/download/v1.5.0/chsl-macos-x64.tar.gz"
    sha256 "acc46e597d70342e73c0d27685163a4843181af8ec7077ac757114e66e13473c"
  elsif OS.linux? && Hardware::CPU.intel?
    url "https://github.com/Snesnopic/chisel/releases/download/v1.5.0/chsl-linux-x64-gcc.tar.gz"
    sha256 "0ccde1687dd1b4ff8e3179b89dd78280b6ef7a9ab7767eb06f9122e0af86b604"
  elsif OS.linux? && Hardware::CPU.arm?
    url "https://github.com/Snesnopic/chisel/releases/download/v1.5.0/chsl-linux-arm64.tar.gz"
    sha256 "3d6f8ae68751c597a2ef35099d017379b4e2e821d5eadc1d5a7fa47fe00f7820"
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
