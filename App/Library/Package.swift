// swift-tools-version:5.5

import PackageDescription

let package = Package(
	name: "Library",
	platforms: [
		.macOS(.v12),
	],
	products: [
		.library(name: "Library", targets: ["Library"]),
	],
	dependencies: [
		.package(url: "https://github.com/screensailor/Hope", .branch("trunk")),
		.package(url: "https://github.com/thousandyears/Lexicon", .branch("trunk")),
		.package(url: "https://github.com/apple/swift-collections", from: "1.0.0"),
		.package(url: "https://github.com/apple/swift-algorithms", from: "1.0.0"),
	],
	targets: [
		.target(
			name: "Library",
			dependencies: [
				.product(name: "Lexicon", package: "Lexicon"),
				.product(name: "SwiftLexicon", package: "Lexicon"),
				.product(name: "LexiconGenerators", package: "Lexicon"),
				.product(name: "Algorithms", package: "swift-algorithms"),
				.product(name: "Collections", package: "swift-collections"),
			],
			resources: [
				.copy("Resources")
			]
		),
		.testTarget(
			name: "LibraryTests",
			dependencies: ["Hope", "Library"]
		),
	]
)
