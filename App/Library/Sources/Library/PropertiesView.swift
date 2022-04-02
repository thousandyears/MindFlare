//
// github.com/screensailor 2022
//

import SwiftUI
import Lexicon

struct PropertiesView: View {
    
    @Environment(\.events) var events
    
    @EnvironmentObject var my: Editor.Object
    
    let ui: CLI.UI.Properties
    
    @State var shouldBeSynonym: Bool?
    @State var shouldShowStats = false
    
    var body: some View {
        GroupBox {
            if let protonym = ui.protonym {
				Synonym(protonym: protonym, synonym: ui.cli.lemma)
            } else {
                InheritanceList(ui: ui)
            }
        }
    }
}

struct Synonym: View {
    
    @Environment(\.events) var events
    @Environment(\.documentID) var id
    
    let protonym: Lemma
	let synonym: Lemma
    
    @State var isHoveringOverRemoveButton = false
    @State var isHoveringOverProtonym = false

    var body: some View {
        HStack {
            
            Text(protonym.description)

            Spacer()
			
			if synonym.isGraphNode {
				
				Button {
					app.document[id].editor.cli.lemma.remove.protonym >> events
				} label: {
					Image(systemName: "xmark")
						.foregroundColor(isHoveringOverProtonym ? NSColor.selectedMenuItemTextColor.ui : .clear)
				}
				.buttonStyle(.plain)
				.onHover {
					isHoveringOverRemoveButton = $0
				}
			}
        }
        .propertyListRow()
        .frame(maxWidth: .infinity, alignment: .leading)
        .foregroundColor(foreground.ui)
        .background(background.ui)
        .cornerRadius(4)
        .onHover {
            isHoveringOverProtonym = $0
        }
        .onTapGesture {
            // TODO: dedicated event ↓
            app.document[id].browser.column.section.heading[protonym].event.tap >> events
        }
    }
    
    var foreground: NSColor {
        .selectedMenuItemTextColor
    }
    
    var background: NSColor {
        isHoveringOverRemoveButton ? .red : .selectedContentBackgroundColor
    }
}

struct InheritanceList: View {
    
    let ui: CLI.UI.Properties

    var body: some View {
        VStack(alignment: .leading, spacing: 1) {
            
            ForEach(ui.type, id: \.self) { type in
				Cell(type: type, lemma: ui.cli.lemma)
            }
            
            if ui.type.isEmpty {
                Text("No inheritance")
                    .propertyListRow()
                    .foregroundColor(Color(nsColor: .placeholderTextColor))
            }
        }
        .frame(maxWidth: .infinity)
    }
}

extension InheritanceList {
    
    struct Cell: View {
        
        @Environment(\.events) var events
		@Environment(\.documentID) var id

        let type: Lemma
		let lemma: Lemma
        
        @State var isHoveringOverInheritance = false
        @State var isHoveringOverRemoveButton = false
        
        var body: some View {
            HStack {
                
                Text(type.id)

                Spacer()
                
				if lemma.isGraphNode {
					
					Button {
						app.document[id].editor.cli.lemma.remove.inheritance[type] >> events
					} label: {
						Image(systemName: "xmark")
							.foregroundColor(isHoveringOverInheritance ? NSColor.selectedMenuItemTextColor.ui : .clear)
					}
					.buttonStyle(.plain)
					.onHover {
						isHoveringOverRemoveButton = $0
					}
				}
            }
            .propertyListRow()
            .foregroundColor(foreground.ui)
            .background(background.ui)
            .cornerRadius(4)
            .onHover {
                isHoveringOverInheritance = $0
            }
            .onTapGesture {
                // TODO: dedicated event ↓
                app.document[id].browser.column.section.heading[type].event.tap >> events
            }
        }
        
        var foreground: NSColor {
            isHoveringOverInheritance ? .selectedMenuItemTextColor : .textColor
        }
        
        var background: NSColor {
            switch (isHoveringOverInheritance, isHoveringOverRemoveButton) {
                case (_, true): return .red
                case (true, _): return .selectedContentBackgroundColor
                default: return .textBackgroundColor
            }
        }
    }
}

extension View {
    
    func propertyListRow() -> some View {
        modifier(PropertiesView.Row())
    }
}

extension PropertiesView {
    
    struct Row: ViewModifier {
        
        func body(content: Content) -> some View {
            content
                .padding(EdgeInsets(top: 3, leading: 5, bottom: 3, trailing: 5))
        }
    }
}
