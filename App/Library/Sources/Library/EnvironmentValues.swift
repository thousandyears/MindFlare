//
// github.com/screensailor 2022
//

import SwiftUI
import SwiftLexicon

extension EnvironmentValues {
    
    var animated: Bool {
        get { self[AnimatedKey.self] }
        set { self[AnimatedKey.self] = newValue }
    }
    private struct AnimatedKey: EnvironmentKey {
        static let defaultValue = false
    }
    
	var documentID: UInt {
        get { self[DocumentIDKey.self] }
        set { self[DocumentIDKey.self] = newValue }
    }
    private struct DocumentIDKey: EnvironmentKey {
        static let defaultValue: UInt = 0
    }

    var focusedDocumentID: UInt? {
        get { self[FocusedDocumentIDKey.self] }
        set { self[FocusedDocumentIDKey.self] = newValue }
    }
    private struct FocusedDocumentIDKey: EnvironmentKey {
        static var defaultValue: UInt?
    }
}
