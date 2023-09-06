//
//  ScreenshotterTests.swift
//

import SwiftUI
import XCTest

import Screenshotter

final class ScreenshotterTests: XCTestCase {
    func testScreens() {
        let view = NavigationStack {
            List {
                Text("Hello, World!")
                Toggle(isOn: .constant(true), label: {
                    Text("Excitement")
                })
            }
        }
        .withSystemDecoration()

        generateScreenshots(for: view, named: "test", types: [
            .iPhone: .portrait,
            .iPad: .all,
        ], prefix: "screenshotter-tests")
    }
}
