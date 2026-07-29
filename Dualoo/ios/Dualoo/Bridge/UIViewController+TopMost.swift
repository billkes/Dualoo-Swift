import UIKit

extension UIViewController {
    var dualooTopMost: UIViewController {
        if let presented = presentedViewController {
            return presented.dualooTopMost
        }
        if let nav = self as? UINavigationController, let visible = nav.visibleViewController {
            return visible.dualooTopMost
        }
        if let tab = self as? UITabBarController, let selected = tab.selectedViewController {
            return selected.dualooTopMost
        }
        return self
    }
}
