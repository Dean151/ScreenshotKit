//
//  iMessageTests.swift
//

#if os(iOS)

import SwiftUI
import XCTest

import ScreenshotKit

@available(iOS 17, *)
final class iMessageTests: XCTestCase {
    func testiMessageScreenshot() {
        generateScreenshots(
            for: {
                List {
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
                    scroll: .top
                )
            },
            named: "imessage-top",
            type: .device(.iPhone(orientations: .portrait)), 
            colorScheme: .all,
            prefix: "tests"
        )

        generateScreenshots(
            for: {
                List {
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
            },
            named: "imessage-bottom",
            type: .device(.iPhone(orientations: .portrait)),
            colorScheme: .all,
            prefix: "tests"
        )

        generateScreenshots(
            for: {
                List {
                    Text("Hello, World!")
                }
                .iMessageApp(
                    recipient: .init(name: "Cécile", picture: .initials("CE")),
                    conversation: [
                        .date("Yesterday, 12:26 PM"),
                        .receivedMessage("Hey, can you send me the codes?"),
                    ],
                    scroll: .bottom
                )
            },
            named: "imessage-not-enough",
            type: .device(.iPhone(orientations: .portrait)),
            colorScheme: .all,
            prefix: "tests"
        )
    }

    func testiPadiMessageScreenshot() {
        generateScreenshots(
            for: {
                List {
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
            },
            named: "imessage-ipad",
            type: .device(.iPad(orientations: .all)),
            colorScheme: .all,
            prefix: "tests"
        )
    }
}

#endif
