import ObjectiveC
import UIKit
import WebKit

enum DualooWebViewDeflavor {
    private static var installed = false

    static func install() {
        guard !installed else { return }
        installed = true
        stripKeyboardAccessoryView()
        swizzleWKWebViewInit()
        swizzleUIViewAddGestureRecognizer()
    }

    static func apply(to webView: WKWebView) {
        let scrollView = webView.scrollView
        scrollView.showsVerticalScrollIndicator = false
        scrollView.showsHorizontalScrollIndicator = false
        scrollView.minimumZoomScale = 1
        scrollView.maximumZoomScale = 1
        scrollView.bouncesZoom = false
        stripDoubleTapGestures(in: scrollView)
    }

    private static func stripKeyboardAccessoryView() {
        guard let contentViewClass = NSClassFromString("WKContentView") else { return }
        let selector = #selector(getter: UIResponder.inputAccessoryView)
        guard let method = class_getInstanceMethod(contentViewClass, selector) else { return }

        let nilAccessory: @convention(block) (AnyObject) -> UIView? = { _ in nil }
        method_setImplementation(method, imp_implementationWithBlock(nilAccessory))
    }

    fileprivate static func stripDoubleTapGestures(in view: UIView) {
        if let gestures = view.gestureRecognizers {
            for gesture in gestures {
                if let tap = gesture as? UITapGestureRecognizer, tap.numberOfTapsRequired == 2 {
                    tap.isEnabled = false
                }
            }
        }
        for subview in view.subviews {
            stripDoubleTapGestures(in: subview)
        }
    }

    private static func swizzleWKWebViewInit() {
        let originalSelector = #selector(WKWebView.init(frame:configuration:))
        let swizzledSelector = #selector(WKWebView.dualoo_swizzledInit(frame:configuration:))

        guard
            let originalMethod = class_getInstanceMethod(WKWebView.self, originalSelector),
            let swizzledMethod = class_getInstanceMethod(WKWebView.self, swizzledSelector)
        else { return }

        method_exchangeImplementations(originalMethod, swizzledMethod)
    }

    private static func swizzleUIViewAddGestureRecognizer() {
        let originalSelector = #selector(UIView.addGestureRecognizer(_:))
        let swizzledSelector = #selector(UIView.dualoo_swizzledAddGestureRecognizer(_:))

        guard
            let originalMethod = class_getInstanceMethod(UIView.self, originalSelector),
            let swizzledMethod = class_getInstanceMethod(UIView.self, swizzledSelector)
        else { return }

        method_exchangeImplementations(originalMethod, swizzledMethod)
    }
}

private extension WKWebView {
    @objc func dualoo_swizzledInit(frame: CGRect, configuration: WKWebViewConfiguration) -> WKWebView {
        let webView = dualoo_swizzledInit(frame: frame, configuration: configuration)
        DualooWebViewDeflavor.apply(to: webView)
        DispatchQueue.main.async {
            DualooWebViewDeflavor.apply(to: webView)
        }
        return webView
    }
}

private extension UIView {
    @objc func dualoo_swizzledAddGestureRecognizer(_ gesture: UIGestureRecognizer) {
        dualoo_swizzledAddGestureRecognizer(gesture)
        if let tap = gesture as? UITapGestureRecognizer, tap.numberOfTapsRequired == 2 {
            tap.isEnabled = false
        }
    }
}
