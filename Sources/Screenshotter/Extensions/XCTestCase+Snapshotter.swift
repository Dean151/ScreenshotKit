//
//  XCTestCase+Snapshotter.swift
//

import SwiftUI
import UIKit
import XCTest

import SnapshotTesting

// MARK: SwiftUI View

extension XCTestCase {
    public func generateScreenshots<Value: SwiftUI.View>(
        for value: @autoclosure () throws -> Value,
        named name: String,
        type: ScreenshotType = .device(.iPhone(orientations: .portrait)),
        prefix: String,
        timeout: TimeInterval = 5,
        file: StaticString = #file,
        line: UInt = #line
    ) rethrows {
        XCTExpectFailure()
        let keyWindow = UIApplication.sharedIfAvailable?.connectedScenes.compactMap({ ($0 as? UIWindowScene)?.windows.first { $0.isKeyWindow } }).first
        try type.each { layout, device in
            for colorScheme in ScreenshotColorScheme.allCases {
                let descriptor: String
                switch layout {
                case .device:
                    descriptor = "\(device)"
                case .fixed(let width, let height):
                    descriptor = "\(Int(width))x\(Int(height))"
                case .sizeThatFits:
                    descriptor = "sizeThatFits"
                }
                let fullName = "\(Locale.current.identifier)-\(descriptor))-\(colorScheme)-\(name)"
                let traits = UITraitCollection(traitsFrom: [
                    .init(displayScale: device.scale),
                    .init(userInterfaceStyle: colorScheme.userInterfaceStyle)
                ])
                assertSnapshot(
                    matching: try value().environment(\.device, device),
                    as: .image(
                        drawHierarchyInKeyWindow: keyWindow != nil,
                        layout: layout,
                        traits: traits
                    ),
                    named: fullName,
                    record: true,
                    timeout: timeout,
                    file: file,
                    testName: prefix,
                    line: line
                )
            }
        }
    }
}
