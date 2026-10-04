cask "oxys" do
  version "1.0.0"
  sha256 "ee534622621c2195664c479fb33889d366f542cd1181bf84a28aab16a8103453"

  url "https://github.com/Taaanos/oxys/releases/download/v#{version}/Oxys.zip"
  name "Oxys"
  desc "Keyboard-first RAW culler"
  homepage "https://github.com/Taaanos/oxys"

  livecheck do
    url :url
    strategy :github_latest
  end

  depends_on arch: :arm64
  depends_on macos: ">= :golden_gate"

  app "Oxys.app"

  # The build has no Developer ID, so Gatekeeper blocks it while the quarantine mark is on it.
  # Homebrew sets the mark on each download; this removes it from the app only.
  postflight do
    system_command "/usr/bin/xattr",
                   args: ["-dr", "com.apple.quarantine", "#{appdir}/Oxys.app"]
  end

  zap trash: [
    "~/Library/Caches/com.thanosam.Oxys",
    "~/Library/Preferences/com.thanosam.Oxys.plist",
    "~/Library/Saved Application State/com.thanosam.Oxys.savedState",
  ]
end
