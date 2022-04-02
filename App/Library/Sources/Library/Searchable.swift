//
// github.com/screensailor 2022
//

import Lexicon
import Combine
import SwiftUI

extension View {
    
    func searchable<A: L & I_app_ui_search>(_ search: K<A>, in lexicon: Binding<Lexicon>) -> some View {
        modifier(Searchable(search, in: lexicon))
    }
}

struct Searchable<A: L & I_app_ui_search>: ViewModifier {

    @Environment(\.events) var events
    @Environment(\.isSearching) var isSearching

    @State var query = ""
    @State var submitted = ""
    
    let search: K<A>
    
    @StateObject var my: Lexicon.Search
    
    func body(content: Content) -> some View {
        content
            .searchable(text: $query, prompt: Text(app.ui.search.prompt(\.localizedType))) {
                ForEach(my.suggestions, id: \.self) { id in
                    Text(id.replacingOccurrences(of: ".", with: " "))
                        .preferredColorScheme(.dark)
                        .lineLimit(1)
                        .truncationMode(.head)
                        .searchCompletion(id)
                }
            }
            .onChange(of: query) { query in
                guard query != submitted else {
                    return
                }
                my.query = query
                search.query[query].did.change >> events
            }
            .onSubmit(of: .search) {
                guard !query.isEmpty else {
                    return
                }
                submitted = query
                search.query[submitted].did.submit >> events
                query = ""
            }
            .modifier(Child(search: search))
    }
    
    init(_ search: K<A>, in lexicon: Binding<Lexicon>) {
        self.search = search
        self._my = .init(wrappedValue: Lexicon.Search(in: lexicon))
    }
    
    struct Child: ViewModifier {
        
        @Environment(\.events) var events
        @Environment(\.isSearching) var isSearching

        let search: K<A>
        
        func body(content: Content) -> some View {
            content.onChange(of: isSearching) { isSearching in
                if isSearching {
                    search.did.start >> events
                } else {
                    search.did.end >> events
                }
            }
        }
    }
}
