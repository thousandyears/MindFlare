//
// github.com/screensailor 2022
//

import SwiftUI

public extension View {
    
    func `as`<A: L_app_ui_view>(_ a: A) -> some View {
        modifier(Semantic(view: K(a)))
    }
    
    func `as`<A: L>(_ k: K<A>) -> some View where A: I_app_ui_view {
        modifier(Semantic(view: k))
    }
}

public struct Semantic<A: L>: ViewModifier where A: I_app_ui_view {
    
    @Environment(\.events) var events
    
    public let view: K<A>
    
    public func body(content: Content) -> some View {
        content
            .onAppear {
                view.did.appear >> events
            }
            .onDisappear {
                view.did.disappear >> events
            }
    }
}
