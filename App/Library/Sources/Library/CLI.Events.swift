//
// github.com/screensailor 2022
//

import SwiftUI
import Lexicon
import UniformTypeIdentifiers

// TODO: enable dictation!

extension View {
    
    func cliEvents<A: L & I_app_ui_cli>(
        for cli: K<A>,
        while isEnabled: @escaping () -> Bool = { true }
    ) -> some View {
        modifier(CLI.Events(cli: cli, isEnabled: isEnabled))
    }
}

extension CLI {
    
    struct Events<A: L & I_app_ui_cli>: ViewModifier {
        
        @Environment(\.events) var events
        @Environment(\.window) var window
		@Environment(\.isSearching) var isSearching

        let cli: K<A>
        let isEnabled: () -> Bool

        func body(content: Content) -> some View {
            
            content.onReceive(NSWindow.keyDown) { event in
                
                guard
                    event.window === window.reference,
					!isSearching,
                    isEnabled()
                else {
                    return
                }
                
                if event.keyCode == .escKey {
                    app.menu.edit.cancel >> events
                    return
                }

                switch (event.specialKey, event.characters.map(String.init(_:))) {
						
					case (_, "\r"):
						break

                    case (.delete?, _), (.leftArrow?, _):
                        if event.modifierFlags.contains(.command) {
                            cli.reset >> events
                        } else {
                            cli.backspace >> events
                        }

                    case (.tab?, _), (.rightArrow?, _), (_, " "), (_, "."):
                        cli.enter >> events
                        
                    case (.upArrow?, _):
                        cli.select.previous >> events
                        
                    case (.downArrow?, _):
                        cli.select.next >> events
                        
					case (_, let c?)
						where event.modifierFlags.isDisjoint(with: [.control, .option, .command])
						&& c.count == 1:
						
                        cli.append[c.first!] >> events
                        
                    default:
                        break
                }
            }
        }
    }
}

private extension UInt16 {
    static let escKey: UInt16 = 53
}
