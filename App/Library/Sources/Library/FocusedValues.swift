//
// github.com/screensailor 2022
//

import SwiftUI

extension FocusedValues {
    
    var focusedDocumentID: UInt? {
        get { self[FocusedDocumentIDKey.self] }
        set { self[FocusedDocumentIDKey.self] = newValue }
    }
    private struct FocusedDocumentIDKey: FocusedValueKey {
        typealias Value = UInt
    }
}
