//
// github.com/screensailor 2022
//

import SwiftUI

struct WelcomeView: View {
    
    @Environment(\.window) var window
    
    var body: some View {
        Text("Hi")
            .frame(
                minWidth: 515, maxWidth: .infinity,
                minHeight: 350, maxHeight: .infinity
            )
        
            .background(NSColor.controlBackgroundColor.ui.opacity(0.9))
            .transition(AnyTransition.opacity)
        
            .onChange(of: window) { window in
                window.reference?.titlebarAppearsTransparent = true
            }
    }
}
