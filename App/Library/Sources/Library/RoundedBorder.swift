//
// github.com/screensailor 2022
//

import SwiftUI

extension View {
    
    func roundedBorder() -> some View {
        modifier(RoundedBorder())
    }
}

struct RoundedBorder: ViewModifier {
    
    var rectangle: some Shape {
        RoundedRectangle(cornerRadius: 5, style: .circular)
    }
    
    func body(content: Content) -> some View {
        content
            .clipShape(rectangle)
            .background(rectangle.stroke(NSColor.separatorColor.ui))
    }
}
