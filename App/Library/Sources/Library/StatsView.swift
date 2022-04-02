//
// github.com/screensailor 2022
//

import SwiftUI
import Lexicon

struct StatsButton: View {
	
	let id: UInt
    
    @Environment(\.events) var events
    
    @State var my: Editor.Object?
    
    @State var bear: Mind = []
    
    @Bear var mind: Mind {
        
        app.document[id].editor.show.stats >> events.then { event in
            guard my == nil else {
                my = nil
                return
            }
            my = try? event[app.document.editor]
        }
    }
    
    var body: some View {
        Button {
            app.menu.view.stats >> events
        } label: {
            Label("Stats", systemImage: "flame")
        }
        .help("Show Stats (⌘ L)")
        .popover(item: $my) { my in
            StatsView().environmentObject(my)
        }
        .onAppear {
            bear.in(mind)
        }
    }
}

struct StatsView: View {
    
    @EnvironmentObject var my: Editor.Object
    
    @State var name = "..."
    @State var count = (nodes: "", synonyms: "", types: "")
    
    var body: some View {
		VStack(alignment: .center) {
			ZStack{}
			.frame(width: 256, height: 256)
			.background(Image("FlareImage").resizable().scaledToFit())
			Text("MindFlare")
                .font(.title)
            Divider()
            HStack {
				Spacer()
                VStack(alignment: .leading) {
                    Text("Lexicon \t\t\(name)")
                    Text("Nodes \t\t\(count.nodes)")
                    Text("Synonyms \t\(count.synonyms)")
                    Text("Inheritance \t\(count.types)")
                }.fixedSize()
                Spacer()
            }
            Divider()
			Text(my.snapshot.graph.date.formatted(date: .long, time: .shortened))
                .font(.caption)
        }
        .padding()
        .task {
            
			self.name = my.snapshot.graph.root.name
            
            var count = (nodes: 0, synonyms: 0, types: 0)
            
			my.snapshot.graph.root.traverse(name: "o") { id, name, node in
                count.nodes += 1
                count.synonyms += node.protonym == nil ? 0 : 1
                count.types += node.type.count
            }
            
            self.count = ("\(count.nodes)", "\(count.synonyms)", "\(count.types)")
        }
    }
}
