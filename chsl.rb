class Chisel < Formula
  desc "Experimental project aiming to recreate the functionality of FileOptimizer"
  homepage "https://github.com/Snesnopic/chisel"
  version "1.0.1"
  license "MIT"

  head "https://github.com/Snesnopic/chisel.git", branch: "main"
  
  depends_on "cmake" => :build
  depends_on "rust" => :build

  if OS.mac? && Hardware::CPU.arm?
    url "https://github.com/Snesnopic/chisel/releases/download/v1.0.1/chisel-macos-arm64.tar.gz"
    sha256 "81105ac4597cccd17a84b2f39bf0cfb237806c78e0164d4bd4b96d8488527b15"
  elsif OS.mac? && Hardware::CPU.intel?
    url "https://github.com/Snesnopic/chisel/releases/download/v1.0.1/chisel-macos-x64.tar.gz"
    sha256 "0d961362dc22d05e22644b3f1be064509b9e5ba6bf02ff8f0f7cce219e691c9e"
  elsif OS.linux? && Hardware::CPU.intel?
    url "https://github.com/Snesnopic/chisel/releases/download/v1.0.1/chisel-linux-x64-gcc.tar.gz"
    sha256 "846a24b7ac2f4472fca6e867fbe9e5555f68bb8d47faa61afe4c20ac351165ed"
  elsif OS.linux? && Hardware::CPU.arm?
    url "https://github.com/Snesnopic/chisel/releases/download/v1.0.1/chisel-linux-arm64.tar.gz"
    sha256 "87c001cc793cf9d97531ca6736a9bd060ff55d14546e592ed087eb0e37e5738d"
  end

  def install
    if build.head?
      # Compilazione da sorgente per --HEAD
      system "cmake", "-S", ".", "-B", "build", *std_cmake_args
      system "cmake", "--build", "build", "--config", "Release"
      bin.install "build/bin/Release/chsl"
    else
      if OS.mac? && Hardware::CPU.arm?
        bin.install "chsl-macos-arm64" => "chsl"
      elsif OS.mac? && Hardware::CPU.intel?
        bin.install "chsl-macos-x64" => "chsl"
      elsif OS.linux? && Hardware::CPU.intel?
        bin.install "chsl-linux-x64-gcc" => "chsl"
      elsif OS.linux? && Hardware::CPU.arm?
        bin.install "chsl-linux-arm64" => "chsl"
      end
    end
  end

  test do
    assert_match "chisel", shell_output("#{bin}/chsl --help")
  end
end
