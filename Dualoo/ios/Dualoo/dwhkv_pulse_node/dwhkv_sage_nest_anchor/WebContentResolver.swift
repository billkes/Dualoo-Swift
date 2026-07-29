import Foundation

enum WebContentResolver {
    static func resolve() -> WebContentSource? {
        guard let url = URL(string: DualooShellConfig.h5EntryUrl) else {
            return nil
        }
        print("[Dualoo] Loading remote H5: \(url.absoluteString)")
        return .remote(url)
    }
}
