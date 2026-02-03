// swift-tools-version:5.5
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "UdentifyVC",
    platforms: [
        .iOS(.v13)
    ],
    products: [
        // Products define the executables and libraries a package produces, making them visible to other packages.
        .library(
            name: "UdentifyVC",
            targets: ["UdentifyVC"]
        ),
    ],
    dependencies: [
        // Existing dependency
        .package(url: "https://github.com/livekit/client-sdk-swift.git", .exact("2.2.1")),
        
        // New dependency for UdentifyCommons
        .package(
            name: "UdentifyCommons",
            url: "https://github.com/fraudcom/UdentifyCommons.git",
            .exact("25.4.0")
        ),
    ],
    targets: [
        // Targets are the basic building blocks of a package, defining a module or a test suite.
        // Targets can depend on other targets in this package and products from dependencies.
        
        .target(
            name: "UdentifyVC",
            dependencies: [
                .product(name: "UdentifyCommons", package: "UdentifyCommons"),
                .product(name: "LiveKit", package: "client-sdk-swift")
            ],
            path: "Sources/UdentifyVC",
            resources: [
                // Add resources if your package uses any
                // e.g., .process("Resources")
            ]
        ),
        
        // If you have tests or additional targets, include them here
    ]
)
