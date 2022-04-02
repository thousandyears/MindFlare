//
// github.com/screensailor 2022
//

import SwiftUI
import Lexicon

struct Editor: View {
	
	@EnvironmentObject var my: Object

	@Environment(\.events) var events
    @Environment(\.animated) var animated
	@Environment(\.undoManager) var undoManager
	
	@Environment(\.focusedDocumentID) var focusedDocumentID
	@Environment(\.documentID) var documentID
	
	let document: Document
	
	@Binding var isExporting: Bool

    var body: some View {
        
        VStack(alignment: .leading, spacing: 8) {
            CLIView(text: my.ui.text)
            ColumnsView(columns: my.ui.columns)
            PropertiesView(ui: my.ui.properties)
        }
		.cliEvents(for: my.doc.browser.cli)
		.searchable(my.doc.editor.search, in: Binding(get: { my.cli.lemma.lexicon }, set: { _ in }))
		
        .animation(animated ? .default : nil, value: my.cli)
		.padding(.horizontal)
        .padding(.bottom)
        
        .fileExporter(
			isPresented: $isExporting,
            document: document,
			contentType: document.export?.generator.utType ?? .data,
            defaultFilename: document.description
        ) { _ in }
		
		.onChange(of: document) { document in
			my.document = document
		}
		
		.onChange(of: document.snapshot) { snapshot in
			my.revert(to: snapshot)
		}
		
		.onChange(of: my.snapshot) { snapshot in
			document.update(with: snapshot, undo: undoManager)
		}

		.onChange(of: focusedDocumentID) { focusedDocumentID in
			my.focusedDocumentID = focusedDocumentID
		}
    }
}
