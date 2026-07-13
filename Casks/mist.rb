cask "mist" do
  version "0.13.0"
  sha256 "5c0843f1e884b9037e83de2d278ae653f4f08d7e1968ec64b33244e484dfbab3"

  url "https://github.com/98przem/mist/releases/download/v#{version}/Mist.dmg"
  name "Mist"
  desc "Play Windows Steam and Epic games through Wine"
  homepage "https://github.com/98przem/mist"

  depends_on macos: :sonoma

  app "Mist.app"

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
