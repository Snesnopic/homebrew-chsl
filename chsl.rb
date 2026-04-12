class Chsl < Formula
  desc "Experimental project aiming to recreate the functionality of FileOptimizer"
  homepage "https://github.com/Snesnopic/chisel"
  version "1.4.1"
  license "MIT"

  head "https://github.com/Snesnopic/chisel.git", branch: "main"

  depends_on "cmake" => :build
  depends_on "rust" => :build

  if OS.mac? && Hardware::CPU.arm?
    url "https://github.com/Snesnopic/chisel/releases/download/v1.4.1/chsl-macos-arm64.tar.gz"
    sha256 "fa32364db7e62ef15f44767ea30e6600687bc5ef419f96d48c59564223da5abb"
  elsif OS.mac? && Hardware::CPU.intel?
    url "https://github.com/Snesnopic/chisel/releases/download/v1.4.1/chsl-macos-x64.tar.gz"
    sha256 "3cac494ed683bdea6bf34c5caf7306f9460c7ef0e38dcc95ed23aed97215bb05"
  elsif OS.linux? && Hardware::CPU.intel?
    url "https://github.com/Snesnopic/chisel/releases/download/v1.4.1/chsl-linux-x64-gcc.tar.gz"
    sha256 "482c8c2fbc5ca784e812ee4b76aa73bf7fc50c3c266712d08b9e164d5eee2c04"
  elsif OS.linux? && Hardware::CPU.arm?
    url "https://github.com/Snesnopic/chisel/releases/download/v1.4.1/chsl-linux-arm64.tar.gz"
    sha256 "11c2e98b0fdfd6726e3523d5cb5032a262f813fb9586bb5b250fe27e7f16d824"
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
