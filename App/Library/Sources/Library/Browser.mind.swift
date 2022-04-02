//
// github.com/screensailor 2022
//

import SwiftUI
import Lexicon

extension Browser.Object {
    
    // TODO: refactor with Editor.Object ↓
    
    var doc: K<L_app_document> { app.document[id] }
    
    @Bear var mind: Mind {
        mindBrowser
        mindCLI
        mindEditMenu
        mindViewMenu
    }

    @Bear var mindBrowser: Mind {
        
        doc.browser.cli.commit >> then { my, event in
            switch my.uiContext {
                    
                case .inheriting:
                    my.doc.browser.cli.lemma.add.inheritance[my.cli.lemma] >> my.events
                    
                case .synonym:
                    my.doc.browser.cli.lemma.add.protonym[my.cli.lemma] >> my.events
                    
                default:
                    break
            }
        }
        
        doc.browser.column.cell.event.tap >> then { my, event in
            guard let lemma: Lemma = try? event[app.document.browser.column.cell] else {
                return
            }
            if my.uiContext == .synonym {
                guard await lemma.isDescendant(of: my.cli.root) else {
                    return
                }
            }
            my.cli = await my.cli.reseting(to: lemma)
        }
    }

    @Bear var mindCLI: Mind {
        
        doc.browser.cli.did.change >> then { my, event in
            
            my.ui = await my.cli.ui( // TODO: refactor
                parent: my.parentCLI,
                canCommit: my.uiContext == .synonym
                ? my.parentCLI.lemma.isValid(protonym: my.cli.lemma)
                : my.parentCLI.lemma.isValid(newType: my.cli.lemma)
            )

            guard my.cli.lemma.id != my.back.last else {
                return
            }

            my.back.append(my.cli.lemma.id)
            my.forward.removeAll()
        }
        
        doc.browser.cli.append >> then { my, event in
            guard let c: Character = try? event[] else { return }
            my.cli = await my.cli.appending(c)
        }
        
        doc.browser.cli.backspace >> then { my, event in
            let cli = await my.cli.backspaced()
            if my.uiContext == .synonym {
                guard await my.cli.root.isAncestor(of: cli.lemma) else {
                    return
                }
            }
            my.cli = cli
        }
        
        doc.browser.cli.enter >> then { my, event in
            my.cli = await my.cli.entered()
        }
        
        doc.browser.cli.reset >> then { my, event in // TODO: esc also closes the popover :(
            my.cli = await my.cli.reseting()
        }
        
        doc.browser.cli.select.next >> then { my, event in
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
                my.cli = await my.cli.reseting(to: lemma)
            } else {
                my.cli.selectNext(cycle: true)
            }
        }
        
        doc.browser.cli.select.previous >> then { my, event in
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
                my.cli = await my.cli.reseting(to: lemma)
            } else {
                my.cli.selectPrevious(cycle: true)
            }
        }
    }
    
    @Bear var mindEditMenu: Mind {
        
        let pb = NSPasteboard.general
        
        app.menu.edit.copy.lemma >> then { my, event in
            pb.clearContents()
            pb.setString(my.cli.description, forType: .string)
        }
        
        app.menu.edit.copy.lexicon >> then { my, event in
            let string = await TaskPaper.encode(my.cli.lemma.graph)
            pb.clearContents()
            pb.setString(string, forType: .string)
        }
        
        app.menu.edit.paste.default >> then { my, event in
            guard
                let string = pb
                    .string(forType: .string)?
                    .trimmingCharacters(in: .whitespacesAndNewlines),
                let lemma = await my.cli.lemma.lexicon[string]
            else {
                return
            }
            my.cli = await my.cli.reseting(to: lemma)
        }
    }
    
    @Bear var mindViewMenu: Mind {
        
        app.menu.view.back >> then { my, event in
            guard
                let currentID = my.back.last
            else {
                return
            }
            my.forward.append(currentID)
            my.back = my.back.dropLast()
            guard let id = my.back.last else { return }
            guard let lemma = await my.cli.lemma.lexicon[id] else { return } // TODO: handle renaming and deleting
            my.cli = await my.cli.reseting(to: lemma)
        }
        
        app.menu.view.forward >> then { my, event in
            guard
                let id = my.forward.last
            else {
                return
            }
            my.forward = my.forward.dropLast()
            my.back.append(id)
            guard let lemma = await my.cli.lemma.lexicon[id] else { return }
            my.cli = await my.cli.reseting(to: lemma)
        }
    }
}
