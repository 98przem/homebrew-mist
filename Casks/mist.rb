cask "mist" do
  version "0.10.0"
  sha256 "06655a383c30144813467510bf6584a13ae51826ea2a425f223ea5ba01939df6"

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
