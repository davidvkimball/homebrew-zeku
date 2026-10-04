cask "zeku" do
  version "0.1.19"
  sha256 "e35303097416c1a00ea9c87eeaa0f0a2d50611af7de0e843d9f310dfdb174927"

  url "https://releases.zeku.dev/download/Zeku_#{version}_universal.dmg"
  name "Zeku"
  desc "Writing app for Astro sites"
  homepage "https://zeku.dev/"

  livecheck do
    url "https://releases.zeku.dev/latest.json"
    strategy :json do |json|
      json["version"]
    end
  end

  auto_updates true
  depends_on macos: ">= :catalina"

  app "Zeku.app"

  # Zeku is not notarized yet, so macOS would refuse the first launch of a downloaded copy. This clears the quarantine flag, as the install script on zeku.dev does.
  postflight do
    system_command "/usr/bin/xattr",
                   args: ["-dr", "com.apple.quarantine", "#{appdir}/Zeku.app"]
  end

  zap trash: [
    "~/Library/Application Support/dev.zeku",
    "~/Library/Caches/dev.zeku",
    "~/Library/Preferences/dev.zeku.plist",
    "~/Library/Saved Application State/dev.zeku.savedState",
    "~/Library/WebKit/dev.zeku",
  ]
end
