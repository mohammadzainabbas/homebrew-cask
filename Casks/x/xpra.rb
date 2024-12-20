cask "xpra" do
  arch arm: "arm64", intel: "x86_64"

  on_arm do
    version "6.2.1,0"
    sha256 "e50e54da1b54604f0432e8ee2288254cc2cc48a2a1e1bdf8d0a55404d8cbd879"
  end
  on_intel do
    version "6.2.1,0"
    sha256 "dcca9120cc241f6e483f4b20de84d9e9bb7b877957c711dfb37f9329ebba0f2b"
  end

  url "https://xpra.org/dists/MacOS/#{arch}/Xpra-#{arch}-#{version.csv.first}-r#{version.csv.second}.dmg",
      verified: "xpra.org/"
  name "Xpra"
  desc "Screen and application forwarding system"
  homepage "https://github.com/Xpra-org/xpra/"

  livecheck do
    url "https://xpra.org/dists/MacOS/#{arch}/"
    regex(/href=.*?Xpra-#{arch}[._-]v?(\d+(?:\.\d+)+)(?:[._-]r(\d+))?\.dmg/i)
    strategy :page_match do |page, regex|
      page.scan(regex).map do |match|
        match[1] ? "#{match[0]},#{match[1]}" : match[0]
      end
    end
  end

  depends_on macos: ">= :sierra"

  app "Xpra.app"

  zap delete: "/Library/Application Support/Xpra",
      trash:  [
        "~/Library/Application Support/Xpra",
        "~/Library/Saved Application State/org.xpra.xpra.savedState",
      ]

  caveats do
    requires_rosetta
  end
end
