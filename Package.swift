// swift-tools-version:5.5
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "UIFontIcons",
    platforms: [
        .iOS(.v9),
        .macOS(.v10_10),
        .tvOS(.v9),
        .watchOS(.v3),
    ],
    products: [
        // Products define the executables and libraries produced by a package, and make them visible to other packages.
        .library(
            name: "UIFontIcons",
            targets: [
                "UIFontIcons"
            ]
        ),
        .library(
            name: "UIFontIconsFeather",
            targets: [
                "Feather"
            ]
        ),
        .library(
            name: "UIFontIconsMaterialIcons",
            targets: [
                "MaterialIcons"
            ]
        ),
        .library(
            name: "UIFontIconsFontAwesome",
            targets: [
                "FontAwesome"
            ]
        ),
    ],
    dependencies: [
        // Dependencies declare other packages that this package depends on.
        // .package(url: /* package url */, from: "1.0.0"),
    ],
    targets: [
        // Targets are the basic building blocks of a package. A target can define a module or a test suite.
        // Targets can depend on other targets in this package, and on products in packages which this package depends on.
        .target(
            name: "UIFontIcons",
            dependencies: [
            ],
            path: "Sources/UIFontIcons/",
            resources: [
                .process("Resources"),
            ]
        ),
        .target(
            name: "Feather",
            dependencies: [
                "UIFontIcons"
            ],
            path: "Sources/Feather/",
            resources: [
                .process("Resources"),
            ]
        ),
        .target(
            name: "FontAwesome",
            dependencies: [
                "UIFontIcons"
            ],
            path: "Sources/FontAwesome/",
            resources: [
                .process("Resources"),
            ]
        ),
        .target(
            name: "MaterialIcons",
            dependencies: [
                "UIFontIcons"
            ],
            path: "Sources/MaterialIcons/",
            resources: [
                .process("Resources"),
            ]
        ),
        .testTarget(
            name: "UIFontIconsTests",
            dependencies: [
                "UIFontIcons",
                "Feather",
                "FontAwesome",
                "MaterialIcons"
            ],
            path: "Tests/UIFontIcons/",
            exclude: [
                "Resources/README.md",
                "Toolbox/README.md",
            ],
            resources: [
                .process("Resources"),
            ]
        ),
    ]
)
