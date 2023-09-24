//
//  iMessageTests.swift
//

import SwiftUI
import XCTest

import ScreenshotKit

@available(iOS 17, *)
final class iMessageTests: XCTestCase {
    func testiMessageScreenshot() {
        let view = List {
            Text("Hello, World!")
        }
        .iMessageApp(
            recipient: .init(name: "Cécile", picture: .initials("CE")),
            conversation: [
                .date("Yesterday, 12:26 PM"),
                .receivedMessage("Hey, can you send me the codes?"),
                .sentMessage("Sure, right away!"),
                .receivedMessage("Hey, can you send me the codes?"),
                .sentMessage("Sure, right away!"),
                .receivedMessage("Hey, can you send me the codes?"),
                .sentMessage("Sure, right away!"),
                .date("Today, 12:26 PM"),
                .receivedMessage("Hey, can you send me the codes? I cannot find them again!"),
                .sentMessage("Sure, right away!"),
                .sentMessage("Here they are:"),
                .indicator("Read at 12:31 PM"),
            ],
            scroll: .bottom
        )

        generateScreenshots(
            for: view,
            named: "imessage",
            type: .device(.iPhone(orientations: .portrait)), 
            colorScheme: .all,
            prefix: "tests"
        )
    }
}
