class Claudio < Formula
  desc "Animated desktop banner for Claude Code on macOS"
  homepage "https://github.com/nappozord/claudio_desktop_notifier"
  url "https://github.com/nappozord/claudio_desktop_notifier/archive/refs/tags/v1.5.0.tar.gz"
  sha256 "2a3918ee9c89a0827fa28ae67ad2793e9f82ed4c1f1fcd9e8c30b0d6a7cdb42e"

  depends_on "jq"
  depends_on :macos

  def install
    mkdir "build"
    system "swiftc", "-O", *Dir["src/*.swift"], "-o", "build/claudio"
    libexec.install "build", "scripts", "install.sh", "uninstall.sh"
    bin.install_symlink libexec/"build/claudio"

    # Through opt_libexec, so the hooks claudio-setup registers keep working after `brew upgrade`.
    { "claudio-setup" => "install.sh", "claudio-uninstall" => "uninstall.sh" }.each do |name, script|
      (bin/name).write <<~SH
        #!/bin/sh
        exec "#{opt_libexec}/#{script}" "$@"
      SH
      chmod 0755, bin/name
    end
  end

  def caveats
    <<~EOS
      To turn Claudio on, run this once:
        claudio-setup

      It registers Claudio's hooks in ~/.claude/settings.json (a backup is kept).
      Already-open Claude Code sessions need /hooks opened once, or a restart.
      Upgrades need no re-run.

      To turn it off before `brew uninstall claudio`:
        claudio-uninstall
    EOS
  end

  test do
    assert_match "crown", shell_output("#{bin}/claudio --props")
  end
end
