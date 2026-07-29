import Foundation

enum DualooShellConfig {
    static let assetScheme = "dualoo-asset"
    /// Vite dev entry — hardcoded in native shell; run `h5-post --sync-dev-url` to refresh LAN IP.
    static let h5EntryUrl = "http://192.168.11.74:5174/"
}
