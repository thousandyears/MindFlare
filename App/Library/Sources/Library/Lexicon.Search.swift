//
// github.com/screensailor 2022
//

import Lexicon
import Combine
import Foundation
import SwiftUI

extension Lexicon {
    
    @MainActor class Search: EventContext {
        
        @Environment(\.events) var events: Events

        @Binding var lexicon: Lexicon
        nonisolated var description: String { "Lexicon search" }
        
        @Published var suggestions: [String] = []
        
        var query: String = "" { didSet { stream.send(query) }}
        var store: [String: [String]] = [:]
        
        private var task: Task<(), Error>?
        
        private let stream = PassthroughSubject<String, Never>()
        private var bag: Set<AnyCancellable> = []
        
        init(in lexicon: Binding<Lexicon>) {
            self._lexicon = lexicon
            stream
                .debounce(for: 0.1, scheduler: RunLoop.main)
                .removeDuplicates()
                .sink{ query in self.update(to: query) }
                .store(in: &bag)
        }
        
        private func update(to query: String) {
            task?.cancel()
            
            guard !query.isEmpty else {
                store = [:]
                suggestions = []
                return
            }
            
            let needle = query.localizedLowercase.replacingOccurrences(of: " ", with: ".")
            
            if let stored = store[needle] {
                suggestions = stored
                return
            }
            
            task = Task.detached { @Sendable [weak self] in
                
                guard let self = self else { return }
                
                try Task.checkCancellation()
                
                let (lemma, prefixes) = await self.lexicon.rootAndPrefixes(in: needle)
                
                let suggestions = await lemma.find(prefixes, max: 1000).map(\.id)
                
                Task { @MainActor [weak self] in
                    guard let self = self else { return }
                    self.store[needle] = suggestions
                    try Task.checkCancellation()
                    guard query == self.query else { return }
                    self.suggestions = suggestions
                }
            }
        }
    }
}

extension Lexicon {
    
    func rootAndPrefixes(in string: String) -> (lemma: Lemma, prefixes: [String]) {
        var prefixes = string.components(separatedBy: ".")
        guard prefixes.first == root.name else {
            return (root, prefixes)
        }
        var lemma = root
        prefixes.removeFirst()
        while let name = prefixes.first {
            guard let child = lemma.ownChildren[name] else {
                break
            }
            lemma = child
            prefixes.removeFirst()
        }
        return (lemma, prefixes.filter{ !$0.isEmpty })
    }
}
