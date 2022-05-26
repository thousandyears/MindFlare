//
// github.com/screensailor 2022
//

import Algorithms
import SwiftUI
import Lexicon

extension Editor.Object {
    
    var isViewing: Bool { uiContext == .viewing }
    var isRenaming: Bool { uiContext == .renaming }
    var isBrowsing: Bool { uiContext == .inheriting }
    var isSearching: Bool { uiContext == .searching }
	
    var isFocused: Bool { focusedDocumentID == id }
	var isInGraphNode: Bool { cli.lemma.isGraphNode }

    var doc: K<L_app_document> { app.document[id] }
    var browser: K<L_app_document_browser> { doc.browser }
    var editor: K<L_app_document_editor> { doc.editor }

    @Bear var mind: Mind {
        mindCLI
        mindDocumentSearch
		mindFileMenu
        mindEditMenu
        mindViewMenu
    }

    @Bear var mindCLI: Mind {
        
        browser.column.cell.event.tap >> then { my, event in // TODO: animate the scroll
            guard let lemma: Lemma = try? event[app.document.browser.column.cell] else {
                return
            }
            my.cli = await CLI(lemma)
        }
        
        browser.column.section.heading.event.tap >> then { my, event in
            guard let lemma: Lemma = try? event[app.document.browser.column.section.heading] else {
                return
            }
            my.cli = await CLI(lemma)
        }
        
        editor.cli.did.change >> then { my, event in
			//...
        }
        
        browser.cli.append >> then { my, event in
            guard let c: Character = try? event[] else { return }
            my.cli = await my.cli.appending(c)
        }
        
        browser.cli.backspace >> then { my, event in
            my.cli = await my.cli.backspaced()
        }
        
        browser.cli.enter >> then { my, event in
            my.cli = await my.cli.entered()
        }
        
        browser.cli.reset >> then { my, event in
            my.cli = await my.cli.reseting(to: my.cli.root)
        }
        
        browser.cli.select.next >> then { my, event in
            if my.cli.input.isEmpty {
                let lemma = my.cli.lemma
                let cli = await my.cli.backspaced()
                let a = cli.suggestions
                guard a.count > 1, let i = a.firstIndex(of: lemma) else {
                    return
                }
                guard let lemma = a.cycled().dropFirst(i + 1).first(where: { _ in true }) else {
                    return
                }
                my.cli = await CLI(lemma)
            } else {
                my.cli.selectNext(cycle: true)
            }
        }
        
        browser.cli.select.previous >> then { my, event in
            if my.cli.input.isEmpty {
                let lemma = my.cli.lemma
                let cli = await my.cli.backspaced()
                let a = cli.suggestions
                guard a.count > 1, let i = a.firstIndex(of: lemma) else {
                    return
                }
                guard let lemma = a.cycled().dropFirst(i + a.count - 1).first(where: { _ in true }) else {
                    return
                }
                my.cli = await CLI(lemma)
            } else {
                my.cli.selectPrevious(cycle: true)
            }
        }
        
        doc.browser.cli.lemma.add.inheritance >> inFocus { my, event in
            my.uiContext = .viewing
            guard
				let type: Lemma = try? event[],
				let lemma = await my.cli.lemma.add(type: type)
			else {
                return
            }
			my.nextLemma = lemma
        }
        
        doc.browser.cli.lemma.add.protonym >> inFocus { my, event in
            my.uiContext = .viewing
            guard let lemma: Lemma = try? event[] else {
                return
            }
            guard let lemma = await my.cli.lemma.set(protonym: lemma) else {
				return
            }
			my.nextLemma = lemma
        }
        
        editor.cli.lemma.remove.inheritance >> then { my, event in
            guard
                let type: Lemma = try? event[],
                let lemma = await my.cli.lemma.remove(type: type)
            else {
                return
            }
            my.nextLemma = lemma
        }
        
        editor.cli.lemma.remove.protonym >> then { my, event in
            guard
                let lemma = await my.cli.lemma.removeProtonym()
            else {
                return
            }
            my.nextLemma = lemma
        }
        
        editor.cli.lemma.rename.to >> inFocus { my, event in
            guard
                let name: Lemma.Name = try? event[],
                let lemma = await my.cli.lemma.rename(to: name)
            else {
                return // TODO: log errors
            }
            my.nextLemma = lemma
        }
    }

    @Bear var mindDocumentSearch: Mind {
        
        editor.search.query.did.submit >> then { my, event in
            guard
                let id: String = try? event[app.document.editor.search.query],
				let lemma = await my.cli.lemma.lexicon[id]
            else {
                return
            }
            my.cli = await CLI(lemma)
        }
    }
	
	@Bear var mindFileMenu: Mind {
		
		app.menu.file.export >> then { my, event in
			guard
				let name: String = try? event[],
				let generator = Lexicon.Graph.JSON.generators[name]
			else {
				return
			}
			let json = await my.cli.lemma.lexicon.json()
			my.document.export = (generator, json)
		}
	}

    @Bear var mindEditMenu: Mind {
        
        let pb = NSPasteboard.general
        
        app.menu.edit.cancel >> inFocus { my, _ in // TODO: add Cancel to the View/Edit menu
            my.uiContext = .viewing
        }
        
        app.menu.edit.commit >> then { my, _ in
            if my.cli.selectedSuggestion?.name == my.cli.input {
                my.cli = await my.cli.entered()
            } else {
                guard let child = await my.cli.lemma.make(child: my.cli.input) else {
                    return
                }
				my.nextLemma = child.parent ?? child
            }
        }
        
        app.menu.edit.commit.and.enter >> then { my, _ in
            if my.cli.selectedSuggestion?.name == my.cli.input {
                my.cli = await my.cli.entered()
            } else {
                guard let child = await my.cli.lemma.make(child: my.cli.input) else {
                    return
                }
				my.nextLemma = child
            }
        }

        app.menu.edit.copy.lemma >> then { my, event in
            pb.clearContents()
            pb.setString(my.cli.description, forType: .string)
        }
        
        app.menu.edit.copy.lexicon >> then { my, event in
            let string = await TaskPaper.encode(my.cli.lemma.graph)
            pb.clearContents()
            pb.setString(string, forType: .string)
        }
        
        app.menu.edit.cut >> then { my, event in
            guard my.cli.lemma.isGraphNode else {
                return // TODO: explain why to the user!
            }
            let string = await TaskPaper.encode(my.cli.lemma.graph)
			guard let lemma = await my.cli.lemma.lexicon.delete(my.cli.lemma) else {
                return // TODO: explain why to the user!
            }
            pb.clearContents()
            pb.setString(string, forType: .string)
            my.nextLemma = lemma
        }
        
        app.menu.edit.inherit >> then { my, event in
            guard
				// TODO: move this ↓ validation to Lemma
				my.cli.lemma.isGraphNode, // TODO: explain why to the user!
				my.cli.lemma.parent != nil,
                await my.cli.lemma.protonym == nil
            else {
                return
            }
            my.uiContext = .inheriting
        }
        
        app.menu.edit.paste.default >> then { my, event in
            guard
				my.cli.lemma.isGraphNode,
                await my.cli.lemma.protonym == nil,
                let string = pb
                    .string(forType: .string)?
                    .trimmingCharacters(in: .whitespacesAndNewlines)
            else {
                return
            }
            if let lemma = await my.cli.lemma.lexicon[string] {
                my.cli = await CLI(lemma)
            }
            else if let graph = try? TaskPaper(string).decode() {
                guard let child = await my.cli.lemma.make(child: graph) else {
					return
				}
				my.nextLemma = child
            }
        }
        
        app.menu.edit.paste.sentences >> then { my, event in
            guard
				my.cli.lemma.isGraphNode,
                await my.cli.lemma.protonym == nil,
                let string = pb.string(forType: .string)
            else {
                return
            }
			Task { @LexiconActor [cli = my.cli] in
				let graph = Lexicon.Graph.from(sentences: string, root: cli.lemma.lexicon.root.name)
				cli.lemma.lexicon.reset(to: graph)
				let newCLI = CLI.with(lemma: cli.lemma.lexicon.root)
				Task { @MainActor in
					my.cli = newCLI
				}
			}
        }
        
        app.menu.edit.rename >> then { my, event in
            guard my.cli.lemma.isGraphNode else {
                return // TODO: explain to the user
            }
            my.uiContext = .renaming
        }
        
        app.menu.edit.synonym >> then { my, event in
            guard
				my.cli.lemma.isGraphNode, // TODO: explain why to the user!
                my.cli.lemma.parent != nil,
				await my.cli.lemma.protonym == nil
            else {
                return
            }
            my.uiContext = .synonym
        }
        
        app.menu.edit.find >> then { my, event in
            my.uiContext = .searching
        }
        
        editor.search.query.did.submit >> then { my, event in
            my.uiContext = .viewing
        }
    }

    @Bear var mindViewMenu: Mind {
        
        app.menu.view.stats >> then { my, event in
            my.doc.editor[my].show.stats >> my.events // TODO: editor[my] is out of pattern
        }
        
        app.menu.view.back >> then { my, event in
			let (cli, back, forward) = await Self.backwards(cli: my.cli, back: my.back, forward: my.forward)
			my.back = back
			my.forward = forward
			if let cli = cli {
				my.cli = cli
			}
        }
        
        app.menu.view.forward >> then { my, event in
			let (cli, back, forward) = await Self.forwards(cli: my.cli, back: my.back, forward: my.forward)
			my.back = back
			my.forward = forward
			if let cli = cli {
				my.cli = cli
			}
        }
    }
}
