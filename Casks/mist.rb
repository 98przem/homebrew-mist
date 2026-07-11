cask "mist" do
  version :latest
  sha256 :no_check

  url "https://github.com/98przem/mist/releases/latest/download/Mist.dmg"
  name "Mist"
  desc "Play Windows Steam and Epic games through Wine"
  homepage "https://github.com/98przem/mist"

  # Mist ships its own in-app updater, so the cask always fetches the newest
  # release rather than pinning a version.
  auto_updates true
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
end
