
import SwiftUI
import Lexicon

struct SearchView<A: L & I_app_ui_search>: View {
    
    @FocusState private var focused: Bool
    
    @Environment(\.events) var events
    
    @State var query = ""
    @State var submitted = ""
    
    @StateObject var my: Lexicon.Search
    
    let search: K<A>
    
    var body: some View {
        VStack() {
            HStack(alignment: .top) {
                HStack(alignment: .center, spacing: 10) {
                    Image(systemName: "magnifyingglass")
                        .font(.system(size: 20))
                    TextField("Search", text: $query)
                        .textFieldStyle(.plain)
                        .modifier(SpotlightViewModifyer())
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
                        .focused($focused)
                    Button {
                        app.menu.edit.cancel >> events
                    } label: {
                        Image(systemName: "xmark")
                    }
                    .buttonStyle(.plain)
                    .font(.system(size: 20))
                        
                }
                .padding()
            }
            .padding(.top, 40)
            
            ScrollView {
                ForEach(my.suggestions, id: \.self) { suggestion in
                    Row(search: search, text: suggestion)
                }
            }
            .padding([.leading, .trailing], 20)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .edgesIgnoringSafeArea(.all)
        .background(.ultraThinMaterial)
        .onAppear {
            focused = true
        }
    }
    
    init(_ search: K<A>, in lexicon: Binding<Lexicon>) {
        self.search = search
        self._my = .init(wrappedValue: Lexicon.Search(in: lexicon))
    }
    
    struct Row: View {
        
        @Environment(\.events) var events
        let search: K<A>
        
        let text: String
        @State private var hover: Bool = false
        
        var body: some View {
            ZStack {
                hover ? Color.blue : Color.clear
                
                Text(text)
                    .foregroundColor(hover ? Color.white : Color.black)
                    .font(.system(size: 16))
                    .lineLimit(1)
                    .truncationMode(.head)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(2.5)
                    .onHover { isHovered in
                        hover = isHovered
                    }
                    .onTapGesture {
//                        submitted = query
                        search.query[text].did.submit >> events
//                        query = ""
                    }
            }
            .cornerRadius(4)
        }
    }
}

struct SpotlightViewModifyer: ViewModifier {
    var roundedCornes: CGFloat = 6
    let colors: [Color] = [.white, .init(white: 0.9), .white]
    
    func body(content: Content) -> some View {
        content
            .padding()
            .background(.ultraThinMaterial)
            .cornerRadius(roundedCornes)
            .padding(3)
            .font(.system(size: 16))
            
            .shadow(color: .white.opacity(0.5), radius: 5)
    }
}
