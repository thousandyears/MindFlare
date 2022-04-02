//
// github.com/screensailor 2022
//

import SwiftUI
import Lexicon
import LexiconGenerators
import UniformTypeIdentifiers

final class Document: Identifiable, Equatable, ReferenceFileDocument, CustomStringConvertible {
	
	static func == (lhs: Document, rhs: Document) -> Bool {
		lhs === rhs
	}
	
	struct Snapshot: Equatable {
		var old: Lemma.ID?
		var new: Lemma.ID?
		var graph: Lexicon.Graph
	}

	static let readableContentTypes: [UTType] = [.lexicon, .taskpaper]
	static let writableContentTypes: [UTType] = [.lexicon] + Lexicon.Graph.JSON.generators.values.map{ $0.utType }

	let file: FileWrapper?
	
	@Published private(set) var snapshot: Snapshot
	@Published var isExporting = false
	
	var export: (generator: CodeGenerator.Type, json: Lexicon.Graph.JSON)? {
		didSet {
			isExporting = export != nil
		}
	}
    
    var description: String {
        if let name = file?.filename, !name.isEmpty {
			if name.hasSuffix(".taskpaper") {
				return String(name.dropLast(".taskpaper".count))
			}
			else if name.hasSuffix(".lexicon") {
				return String(name.dropLast(".lexicon".count))
			}
			else {
                return name
            }
        } else {
			return snapshot.graph.root.name
        }
    }

    init(graph: Lexicon.Graph? = nil) {
		self.file = nil
		self.snapshot = Snapshot(graph: graph ?? .init())
    }
	
	init(configuration: ReadConfiguration) throws {
        
        guard let data = configuration.file.regularFileContents else {
            throw CocoaError(.fileReadCorruptFile)
        }
        
        switch configuration.contentType {
                
			case .lexicon, .taskpaper:
				snapshot = try Snapshot(graph: TaskPaper(data).decode())
                file = configuration.file
                
            default:
                throw CocoaError(.fileReadUnsupportedScheme)
        }
    }
	
	func update(with new: Snapshot, undo manager: UndoManager?) {
		
		guard new.graph != snapshot.graph else {
			return
		}
		
		let old = Snapshot(old: new.new, new: new.old, graph: snapshot.graph)
		self.snapshot = new
		
		manager?.registerUndo(withTarget: self) { [old, manager] my in
			my.update(with: old, undo: manager)
		}
	}

	func snapshot(contentType: UTType) throws -> Snapshot {
		snapshot
	}
	
	func fileWrapper(snapshot: Snapshot, configuration: WriteConfiguration) throws -> FileWrapper {
        
        let data: Data
        
        switch configuration.contentType {
                
			case .lexicon, .taskpaper:
				data = try TaskPaper.encode(snapshot.graph).data(using: .utf8).try()
                
            default:
				guard
					let (generator, json) = export,
					generator.utType == configuration.contentType
				else {
					throw CocoaError(.fileWriteUnknown)
				}
				data = try generator.generate(json)
        }
        
        return FileWrapper(regularFileWithContents: data)
    }
}
