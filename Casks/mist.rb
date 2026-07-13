cask "mist" do
  version "0.19.0"
  sha256 "6341edad231c665037be3fc325e343e0fbf4a0955383d93e1b00a2a7006ac496"

  url "https://github.com/98przem/mist/releases/download/v#{version}/Mist.dmg"
  name "Mist"
  desc "Play Windows Steam and Epic games through Wine"
  homepage "https://github.com/98przem/mist"

  depends_on macos: :sonoma

  app "Mist.app"

  # Mist is ad-hoc signed (no paid Developer ID, so no notarization) — without
  # this, the quarantine bit `brew install --cask` leaves on a freshly
  # downloaded app makes Gatekeeper run it via App Translocation from a
  # read-only mirrored path instead of the real /Applications/Mist.app.
  # Confirmed live: the app launched, showed zero windows, and the process
  # kept respawning — clearing quarantine after install fixes it outright.
  postflight do
    system_command "/usr/bin/xattr", args: ["-dr", "com.apple.quarantine", "#{appdir}/Mist.app"], sudo: false
  end

  # `brew uninstall --zap mist` removes the app AND every trace of its data:
  # the whole Wine prefix + downloaded games + engine, the login/session files,
  # per-game settings, and preferences.
  zap trash: [
    "~/Library/Application Support/Mist",
    "~/Library/Caches/com.mist.app",
    "~/Library/HTTPStorages/com.mist.app",
    "~/Library/Preferences/com.mist.app.plist",
    "~/Library/Saved Application State/com.mist.app.savedState",
  ]

  # Bumped automatically by mist's own release workflow on every tag push (see
  # 98przem/mist/.github/workflows/release.yml) — version/sha256 above should
  # always match the newest GitHub release, which is what makes `brew upgrade`
  # actually detect new versions (the old `version :latest` never did).
  livecheck do
    url :url
    strategy :github_latest
  end
end
