class Claudio < Formula
  desc "Desktop notification utility"
  homepage "https://github.com/nappozord/claudio_desktop_notifier"
  url "https://github.com/nappozord/claudio_desktop_notifier/releases/download/v1.0.0/claudio-v1.0.0-macos-arm64.tar.gz"
  sha256 "2c932729e1f8b388c8c2657ff98fb704c789d13f429d94a3baddc17e11f8880d"
  version "1.0.0"

  def install
    bin.install "claudio"
  end
end