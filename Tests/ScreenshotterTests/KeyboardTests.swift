//
//  KeyboardTests.swift
//

#if os(iOS)

import SwiftUI
import XCTest

import ScreenshotKit

@available(iOS 17, *)
final class KeyboardTests: XCTestCase {
    func testKeyboardScreenshots() {
        generateScreenshots(
            for: {
                List {
                    Text("Hello, World!")
                }
                .keyboardExtension(keyboardToolbar: {
                    RoundedRectangle(cornerRadius: 16)
                        .fill(.white)
                        .padding(8)
                        .frame(height: 52)
                }, foregroundApp: {
                    Color.blue
                })
            },
            named: "keyboard",
            type: .devices([.iPhone(orientations: .portrait), .iPad(orientations: .landscape)]),
            colorScheme: .all,
            prefix: "tests"
        )
    }
}

#endif
