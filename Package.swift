// swift-tools-version: 6.1
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "SwiftIPly",
    platforms: [
        .iOS(.v13),
        .macOS(.v10_15),
        .tvOS(.v13),
        .watchOS(.v6),
        .visionOS(.v1)
    ],
    products: [
        .library(
            name: "SwiftIPly",
            targets: ["SwiftIPly"]
        ),
        .library(
            name: "SwiftIPlyDynamic",
            type: .dynamic,
            targets: ["SwiftIPly"]
        ),
    ],
    dependencies: [
        // Optional: Only needed if you plan to generate documentation via DocC
        .package(url: "https://github.com/apple/swift-docc-plugin", from: "1.0.0")
    ],
    targets: [
        .target(
            name: "SwiftIPly",
            dependencies: [],
            path: "Sources/SwiftIPly",
            resources: []
        ),
        .testTarget(
            name: "SwiftIPlyTests",
            dependencies: ["SwiftIPly"],
            path: "Tests/SwiftIPlyTests"
        )
        // Uncomment this block if you later want to add an example executable target
        /*
        .executableTarget(
            name: "SwiftIPlyExample",
            dependencies: ["SwiftIPly"],
            path: "Examples/SwiftIPlyExample"
        )
        */
    ]
)
