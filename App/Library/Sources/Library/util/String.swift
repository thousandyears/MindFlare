//
// github.com/screensailor 2022
//

import Lexicon
import Foundation

extension String {
	
	func url(from bundle: Bundle = .module, directory path: String = "Resources/") throws -> URL {
		guard let url = bundle.url(forResource: "\(path)\(self)", withExtension: nil) else {
			throw "Could not find '\(self)'"
		}
		return url
	}
	
	func file(from bundle: Bundle = .module, directory path: String = "Resources/") throws -> Data {
		try Data(contentsOf: self.url(from: bundle, directory: path))
	}
	
	func graph() throws -> Lexicon.Graph {
		try TaskPaper(self).decode()
	}
	
	func lexicon() async throws -> Lexicon {
		try await Lexicon.from(graph())
	}
	
	func lemma(_ id: String) async throws -> Lemma {
		try await lexicon()[id].try()
	}
}

extension Data {
	
	func string(encoding: String.Encoding = .utf8) throws -> String {
		try String(data: self, encoding: encoding).try()
	}
}
