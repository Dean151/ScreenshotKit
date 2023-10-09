//
//  KeyboardTests.swift
//

import SwiftUI
import XCTest

import ScreenshotKit

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
            type: .device(.iPhone(orientations: .portrait)),
            colorScheme: .all,
            prefix: "tests"
        )
    }
}
