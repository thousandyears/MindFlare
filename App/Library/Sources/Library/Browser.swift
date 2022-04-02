//
// github.com/screensailor 2021
//

import SwiftUI

struct Browser: View {
    
    @EnvironmentObject var my: Object
    
    let commitTitle: String

    var body: some View {
        
        VStack(alignment: .leading, spacing: 8) {
            
            CLIView(text: my.ui.text)
            ColumnsView(columns: my.ui.columns)
            
            Button(commitTitle) {
                my.doc.browser.cli.commit >> my.events
            }
            .disabled(!my.ui.canCommit)
            .keyboardShortcut(.return, modifiers: [])
            .foregroundColor(NSColor.selectedMenuItemTextColor.ui)
            
            .padding(.top, 2)
            .frame(maxWidth: .infinity, alignment: .trailing)
        }
        .padding()
        
        .frame(
            minWidth: 515, maxWidth: .infinity,
            minHeight: 350, maxHeight: .infinity
        )
        
        .background(
            NSColor.controlBackgroundColor.ui
                .opacity(0.8)
                .scaleEffect(1.5)
        )
    }
}
