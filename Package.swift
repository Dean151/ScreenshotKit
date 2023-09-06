// swift-tools-version: 5.9

import PackageDescription

let package = Package(
    name: "swift-screenshotter",
    platforms: [.iOS(.v16)],
    products: [
        .library(name: "Screenshotter", targets: ["Screenshotter"]),
    ],
    dependencies: [
        .package(url: "https://github.com/pointfreeco/swift-snapshot-testing.git", from: "1.11.1"),
    ],
    targets: [
        .target(name: "Screenshotter", dependencies: [
            .product(name: "SnapshotTesting", package: "swift-snapshot-testing"),
        ]),
        .testTarget(name: "ScreenshotterTests", dependencies: ["Screenshotter"]),
    ]
)
