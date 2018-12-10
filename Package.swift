// swift-tools-version:4.0
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
	name: "UIFontIcons",
	products: [
		.library(name: "UIFontIcons", targets: ["UIFontIcons"])
	],
	dependencies: [],
	targets: [
	.target(name: "UIFontIcons", dependencies: [], path: "Sources/Shared"),
		.testTarget(name: "UIFontIconsTests", dependencies: ["UIFontIcons"], path: "UIFontIconsTests/Shared")
	]
)
