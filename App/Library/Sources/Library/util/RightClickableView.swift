//
//  Created by Noah Knudsen on 25/07/2022.
//

import SwiftUI

extension View {
    
    func onRightClick(_ action: @escaping () -> ()) -> some View {
        self.modifier(RightClickableModifier(action: action))
    }
}

/// SwiftUI has no notion of a "right click" currently.
/// This modifier therefore wraps an NSVIew to perform and action on right mouse down.
struct RightClickableModifier: ViewModifier {
    
    let action: () -> ()
    
    func body(content: Content) -> some View {
        ZStack{
            RightClickableView(action)
            content
        }
    }
}

private struct RightClickableView: NSViewRepresentable {
    
    let rightClickAction: () -> ()
    
    init(_ rightClickAction: @escaping () -> ()) {
        self.rightClickAction = rightClickAction
    }
    
    func updateNSView(_ nsView: RightClickableNSView, context: NSViewRepresentableContext<RightClickableView>) {
    }
    
    func makeNSView(context: Context) -> RightClickableNSView {
        RightClickableNSView(rightClickAction)
    }
}

private class RightClickableNSView: NSView {

    let rightClickAction: () -> ()
    
    init(_ rightClickAction: @escaping () -> ()) {
        self.rightClickAction = rightClickAction
        super.init(frame: .zero)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func rightMouseDown(with theEvent: NSEvent) {
        rightClickAction()
        super.rightMouseDown(with: theEvent)
    }
}
