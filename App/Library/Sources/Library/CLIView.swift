//
// github.com/screensailor 2022
//

import SwiftUI
import Lexicon

struct CLIView: View {
    
    let text: AttributedString
    
    var body: some View {
        Text(text)
            .padding(.bottom, 8)
            .padding(.horizontal, 8)
            .animation(.none, value: text)
    }
}
