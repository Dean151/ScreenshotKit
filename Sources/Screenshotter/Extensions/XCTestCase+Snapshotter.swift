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
        types: [SimulatedDeviceType: SimulatedDeviceOrientations] = [.iPhone: .portrait],
        prefix: String,
        timeout: TimeInterval = 5,
        file: StaticString = #file,
        testName: String = #function,
        line: UInt = #line
    ) rethrows {
        XCTExpectFailure()
        let keyWindow = UIApplication.sharedIfAvailable?.connectedScenes.compactMap({ ($0 as? UIWindowScene)?.windows.first { $0.isKeyWindow } }).first
        for (type, orientations) in types {
            for orientation in orientations.each {
                for device in SimulatedDevice.matching(type: type, orientation: orientation, screenScale: UIScreen.main.scale) {
                    for colorScheme in [UIUserInterfaceStyle.light, .dark] {
                        let fullName = "\(Locale.current.identifier)-\(device))-\(name)-\(colorScheme)"
                        assertSnapshot(
                            matching: try value().environment(\.device, device),
                            as: .image(
                                drawHierarchyInKeyWindow: keyWindow != nil,
                                layout: .device(config: device.config),
                                traits: .init(userInterfaceStyle: colorScheme)
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
    }
}
