//
// github.com/screensailor 2022
//

import SwiftUI

extension ColorScheme {
    
    func get(inverse: Bool) -> ColorScheme {
        switch self {
            case .light: return inverse ? .dark : .light
            case .dark: return inverse ? .light : .dark
            @unknown default: return self
        }
    }
    
    func appearance(inverse: Bool) -> NSAppearance {
        let name: NSAppearance.Name
        switch self {
            case .light: name = inverse ? .darkAqua : .aqua
            case .dark: name = inverse ? .aqua : .darkAqua
            @unknown default: return NSApplication.shared.effectiveAppearance
        }
        return NSAppearance(named: name) ?? NSApplication.shared.effectiveAppearance
    }
}
