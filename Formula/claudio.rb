class Claudio < Formula
  desc "Desktop notification utility"
  homepage "https://github.com/nappozord/claudio_desktop_notifier"
  url "https://github.com/nappozord/claudio_desktop_notifier/releases/download/v1.1.0/claudio-v1.1.0-macos-arm64.tar.gz"
  sha256 "787063ecb7b4b77119fc00265f10be9c10ff36f7028d6f01db7478913a3ff555"
  version "1.1.0"

  def install
    bin.install "claudio"
  end
end