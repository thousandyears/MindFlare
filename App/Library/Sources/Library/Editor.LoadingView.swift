//
// github.com/screensailor 2022
//

import SwiftUI

extension Editor {
	
	struct LoadingView: View {
		
		private static var count: UInt = 0
		@State var id: UInt = { Self.count += 1; return Self.count }()
		
		@Environment(\.window) var window
		
		@EnvironmentObject var document: Document
		
		@Binding var animated: Bool
		
		@State var my: Editor.Object?

		var body: some View {
			
			ZStack {
				if let my = my {
					Editor(document: document, isExporting: $document.isExporting)
						.as(my.doc.editor.view)
						.environmentObject(my)
						.focusedSceneValue(\.focusedDocumentID, id)
                        .environment(\.focusedDocumentID, id)
				}
			}
			.as(app.document[id].view)
			.environment(\.documentID, id)
            .task {
                my = await Editor.Object(id: id, document: document)
            }
			.frame(
				minWidth: 515, maxWidth: .infinity,
				minHeight: 350, maxHeight: .infinity
			)
			
			.background(NSColor.controlBackgroundColor.ui.opacity(0.9))
			.transition(AnyTransition.opacity)
			
			.onChange(of: window) { window in
				window.reference?.titlebarAppearsTransparent = true
			}

			.toolbar {
				
				ToolbarItemGroup(placement: .navigation) {
					
					StatsButton(id: id)
				}
				
				ToolbarItemGroup(placement: .primaryAction) {
					
					Button {
						animated.toggle()
					} label: {
						if animated {
							Label("Do not animate", systemImage: "hare")
						} else {
							Label("Animate", systemImage: "tortoise")
						}
					}
					.help("Toggle smooth animations")
					
					ColorSchemeButton()
					
					//                    Button {
					//
					//                    } label: {
					//                        Label("Search Settings", systemImage: "doc.text.magnifyingglass")
					//                    }
					//                    .help("This feature is coming soon!")
				}
			}
		}
	}
}
