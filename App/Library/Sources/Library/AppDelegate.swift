//
// github.com/screensailor 2022
//

import SwiftUI
import Combine

class AppDelegate: NSObject, NSApplicationDelegate {

    func applicationDidFinishLaunching(_: Notification) {
        NSWindow.swizzle(
            method: #selector(NSWindow.swizzled_sendEvent(_:)),
            inPlaceOf: #selector(NSWindow.sendEvent(_:))
        )
        NSResponder.swizzle(
            method: #selector(NSResponder.swizzled_noResponder(for:)),
            inPlaceOf: #selector(NSResponder.noResponder(for:))
        )
    }
}

extension NSWindow {
    
    static let keyDown = PassthroughSubject<NSEvent, Never>()
    
    @objc func swizzled_sendEvent(_ event: NSEvent) {
        if event.type == .keyDown {
            NSWindow.keyDown.send(event)
        }
        swizzled_sendEvent(event)
    }
}

extension NSResponder {

    @objc func swizzled_noResponder(for selector: Selector) {
        if selector == #selector(keyDown(with:)) {
            // don't beep!
        } else {
            swizzled_noResponder(for: selector)
        }
    }
}

public extension NSObjectProtocol {
    
    static func swizzle(method new: Selector, inPlaceOf old: Selector) {
        guard
            let old = class_getInstanceMethod(self, old),
            let new = class_getInstanceMethod(self, new)
        else { return }
        method_exchangeImplementations(old, new)
    }
}
