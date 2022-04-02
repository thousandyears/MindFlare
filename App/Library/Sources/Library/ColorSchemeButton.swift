//
// github.com/screensailor 2022
//

import SwiftUI
import Combine

struct ColorSchemeButton: View {
    
    enum Theme: String, CaseIterable {
        
        case dark
        case light
        case system
        
        var appearance: NSAppearance? {
            switch self {
                case .dark: return .init(named: .darkAqua)
                case .light: return .init(named: .aqua)
                case .system: return nil
            }
        }
    }
    
    @AppStorage("theme") var theme: Theme = .system

    @Environment(\.events) var events
    
    var body: some View {
        Button {
            let i = Theme.allCases.firstIndex(of: theme)!
            theme = Theme.allCases.cycled().dropFirst(i + 1).first(where: { _ in true })!
            NSApp.appearance = theme.appearance
            app.menu.view.theme[theme].toggle >> events
        } label: {
            Group {
                switch theme {
                    case .system: Label("Dark Theme", systemImage: "moon.stars")
                    case .dark: Label("Light Theme", systemImage: "sun.max")
                    case .light: Label("System Theme", systemImage: "sun.and.horizon")
                }
            }
            .frame(minWidth: 28)
        }
        .keyboardShortcut("8", modifiers: .command)
        .onAppear{
            NSApp.appearance = theme.appearance
        }
        .help("Just for you, Ollie!")
    }
}
