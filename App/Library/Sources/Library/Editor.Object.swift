//
// github.com/screensailor 2022
//

import Combine
import SwiftUI
import Lexicon
import UniformTypeIdentifiers

extension Editor {
    
    @MainActor final class Object: EventContext {
		
		@Published var ui: CLI.UI.Editor
		@Published var snapshot: Document.Snapshot

		let id: UInt
		let description: String
		
        @Environment(\.events) var events
		
		var document: Document
		var focusedDocumentID: UInt?
		
        lazy var then = context{ my in my.isFocused && my.isViewing }
        lazy var inFocus = context(\.isFocused)
        lazy var inBrowser = context(\.isBrowsing)
		lazy var inRenaming = context(\.isRenaming)
		lazy var inGraphNode = context{ my in my.isFocused && my.isInGraphNode } // TODO: use

        var nextLemma: Lemma? {
            didSet {
                guard let lemma = nextLemma, lemma !== oldValue else {
                    return
                }
                Task { @LexiconActor in
					guard lemma.isConnected else {
						return
					}
					let cli = CLI.with(lemma: lemma)
					let graph = lemma.lexicon.graph
					Task { @MainActor in
						let old = self.cli
						self.cli = cli
						self.snapshot = Document.Snapshot(
							old: old.lemma.id,
							new: lemma.id,
							graph: graph
						)
					}
                }
            }
        }
        
        var uiContext: CLI.UI.Context = .viewing {
            didSet {
                if uiContext != oldValue {
                    Task { @MainActor in
                        ui = await cli.ui(context: uiContext)
                    }
                }
            }
        }
        
        var cli: CLI {
            didSet {
				if cli.lemma.id != back.last {
					back.append(cli.lemma.id)
					forward = []
				}
				Task {
					ui = await cli.ui(context: .viewing)
					doc.editor.cli[cli].did.change >> events
				}
            }
        }

        var back: [Lemma.ID] = []
        var forward: [Lemma.ID] = []

        private var bear: Mind = []
		private var subscription = (
			lexicon: AnyCancellable?.none,
			document: AnyCancellable?.none
		)

		init(id: UInt, document: Document) async {
            
			self.id = id
			self.snapshot = document.snapshot
			self.description = "\(Self.self) #\(id)"
			
			self.document = document
            
			var lemma = await Lexicon.from(document.snapshot.graph).root
			if let id = document.snapshot.new, let o = await lemma.lexicon[id] {
				lemma = o
			}
			cli = await CLI(lemma)
            ui = await cli.ui(context: .viewing)
			
            bear.in(mind)
        }
        
        deinit {
            print("🗑 editor", cli.description, id)
        }
		
		func revert(to snapshot: Document.Snapshot) {
			Task { @LexiconActor [cli, back, forward] in
				
				guard cli.lemma.lexicon.graph != snapshot.graph else {
					return
				}
				
				let root = Lexicon.from(snapshot.graph).root
				let lemma = snapshot.new.flatMap{ root.lexicon[$0] } ?? root.lexicon[cli.lemma.id]
				
				if let lemma = lemma {
					Task { @MainActor in
						self.nextLemma = lemma
					}
				} else {
					let (lemma, back, forward) = Self.backwards(lemma: root, back: back, forward: forward)
					Task { @MainActor in
						self.forward = forward
						self.back = back
						self.nextLemma = lemma ?? root
					}
				}
			}
        }
    }
}

extension Editor.Object {
	
	@LexiconActor static func backwards(cli: CLI, back: [Lemma.ID], forward: [Lemma.ID]) async -> (cli: CLI?, back: [Lemma.ID], forward: [Lemma.ID]) {
		let (lemma, back, forward) = backwards(lemma: cli.lemma, back: back, forward: forward)
		if let lemma = lemma {
			return (CLI.with(lemma: lemma), back, [])
		}
		return (nil, back, forward)
	}
	
	@LexiconActor static func forwards(cli: CLI, back: [Lemma.ID], forward: [Lemma.ID]) async -> (cli: CLI?, back: [Lemma.ID], forward: [Lemma.ID]) {
		let (lemma, back, forward) = forwards(lemma: cli.lemma, back: back, forward: forward)
		if let lemma = lemma {
			return (CLI.with(lemma: lemma), back, [])
		}
		return (nil, back, forward)
	}
	
	@LexiconActor static func backwards(lemma: Lemma, back: [Lemma.ID], forward: [Lemma.ID]) -> (lemma: Lemma?, back: [Lemma.ID], forward: [Lemma.ID]) {
		var back = back
		var forward = forward
		guard let currentID = back.last else {
			return (nil, back, forward)
		}
		back = back.dropLast()
		while let id = back.last {
			guard let lemma = lemma.lexicon[id] else {
				back = back.dropLast()
				continue
			}
			forward.append(currentID)
			return (lemma, back, forward)
		}
		return (nil, [currentID], forward)
	}
	
	@LexiconActor static func forwards(lemma: Lemma, back: [Lemma.ID], forward: [Lemma.ID]) -> (lemma: Lemma?, back: [Lemma.ID], forward: [Lemma.ID]) {
		var back = back
		var forward = forward
		while let id = forward.last {
			forward = forward.dropLast()
			guard let lemma = lemma.lexicon[id] else {
				continue
			}
			back.append(id)
			return (lemma, back, forward)
		}
		return (nil, back, [])
	}
}
