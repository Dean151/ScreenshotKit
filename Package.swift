// swift-tools-version: 5.9

import PackageDescription

let settings: [SwiftSetting] = [.strictConcurrency, .warnLongExpressionTypeChecking]

let package = Package(
    name: "ScreenshotKit",
    platforms: [.iOS(.v16), .macOS(.v13)],
    products: [
        .library(name: "ScreenshotKit", targets: ["ScreenshotKit"]),
    ],
    dependencies: [
        .package(url: "https://github.com/pointfreeco/swift-snapshot-testing.git", from: "1.11.1"),
    ],
    targets: [
        .target(name: "ScreenshotKit", dependencies: [
            .product(name: "SnapshotTesting", package: "swift-snapshot-testing"),
        ], swiftSettings: settings),
        .testTarget(name: "ScreenshotKitTests", dependencies: ["ScreenshotKit"]),
    ]
)

extension SwiftSetting {
    static let strictConcurrency = enableUpcomingFeature("StrictConcurrency")
    static let warnLongExpressionTypeChecking = unsafeFlags(
        [
            "-Xfrontend", "-warn-long-expression-type-checking=100",
            "-Xfrontend", "-warn-long-function-bodies=100",
        ],
        .when(configuration: .debug)
    )
}
