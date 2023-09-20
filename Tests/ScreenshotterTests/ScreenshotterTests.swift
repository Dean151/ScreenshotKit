//
//  ScreenshotterTests.swift
//

import SwiftUI
import XCTest

import ScreenshotKit

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

        generateScreenshots(for: view, named: "device", type: .devices([
            .iPhone(orientations: .portrait),
            .iPad(orientations: .all)
        ]), prefix: "tests")
    }

    func testFixedSize() {
        let view = Button(action: {}, label: {
            Text("Button")
        }).buttonStyle(.borderedProminent)

        generateScreenshots(for: view, named: "fixed", type: .fixed(width: 200, height: 66), prefix: "tests")
    }

    func testSizeThatFit() {
        let view = Button(action: {}, label: {
            Text("Button")
                .frame(maxWidth: .infinity, maxHeight: .infinity)
        }).frame(width: 200, height: 66).buttonStyle(.borderedProminent)

        generateScreenshots(for: view, named: "fit", type: .sizeThatFits, prefix: "tests")
    }
}
