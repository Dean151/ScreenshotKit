// swift-tools-version: 5.9

import PackageDescription

let package = Package(
    name: "ScreenshotKit",
    platforms: [.iOS(.v16)],
    products: [
        .library(name: "ScreenshotKit", targets: ["ScreenshotKit"]),
    ],
    dependencies: [
        .package(url: "https://github.com/pointfreeco/swift-snapshot-testing.git", from: "1.11.1"),
    ],
    targets: [
        .target(name: "ScreenshotKit", dependencies: [
            .product(name: "SnapshotTesting", package: "swift-snapshot-testing"),
        ]),
        .testTarget(name: "ScreenshotKitTests", dependencies: ["ScreenshotKit"]),
    ]
)
