import Foundation

enum DualooSeedAssets {
    // Scaffold: bundled seed rasters live in ios/{AppName}/SeedBundle/ (fixed path — 编组 I).
    private static let seedFilenames: [String] = []

    /// Copy bundled seed photos into Documents/photos/seed/ (idempotent).
    static func ensureCopied() {
        for filename in seedFilenames {
            let rel = "photos/seed/\(filename)"
            if let url = try? DualooFileVault.resolve(rel), FileManager.default.fileExists(atPath: url.path) {
                continue
            }
            guard let data = DualooBundleMedia.data(forBundledFilename: filename) else {
                continue
            }
            try? DualooFileVault.writeData(rel, data: data)
        }
    }
}
