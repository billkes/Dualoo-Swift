import UIKit

enum DualooLaunchStyle {
    static let backgroundColor = UIColor(red: 253 / 255, green: 251 / 255, blue: 247 / 255, alpha: 1)
}

@main
final class AppDelegate: UIResponder, UIApplicationDelegate {
    var window: UIWindow?

    func application(
        _ application: UIApplication,
        didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
    ) -> Bool {
        DualooWebViewDeflavor.install()
        let window = UIWindow(frame: UIScreen.main.bounds)
        window.backgroundColor = DualooLaunchStyle.backgroundColor
        window.rootViewController = DualooWebViewController()
        window.makeKeyAndVisible()
        self.window = window
        return true
    }
}
