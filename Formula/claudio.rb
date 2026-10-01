class Claudio < Formula
  desc "Animated desktop banner for Claude Code on macOS"
  homepage "https://github.com/nappozord/claudio_desktop_notifier"
  url "https://github.com/nappozord/claudio_desktop_notifier/archive/refs/tags/v1.6.0.tar.gz"
  sha256 "c802ab02eb073db6dce3ac448bd5ab47f5f4de01b7f974d3af6533c0d6326eba"

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
