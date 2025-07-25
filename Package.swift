// swift-tools-version: 5.9

import PackageDescription

let package = Package(
    name: "LocalizerKit",
    platforms: [
        .iOS("16.0"),
        .macOS("13.0"),
        .tvOS("16.0"),
        .visionOS("1.0")
    ],
    products: [
        .library(
            name: "LocalizerKit",
            targets: ["LocalizerKit"]
        )
    ],
    targets: [ 
        .target(
            name: "LocalizerKit",
            dependencies: []
        ),
    ]
)
