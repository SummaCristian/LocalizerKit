// swift-tools-version: 5.8

import PackageDescription

let package = Package(
    name: "LocalizerKit",
    platforms: [
        .iOS("16.0")
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
