//
//  SystemDecoration.swift
//
//  Created by Thomas Durand on 23/08/2023.
//  Copyright © 2023 Illumineering. All rights reserved.
//

import SwiftUI

@available(iOS 16.0, *)
public struct WithSystemDecorationModifier: ViewModifier {
    @Environment(\.device)
    private var device

    let homeIndicatorColorScheme: HomeIndicatorColorScheme
    let statusBarColorScheme: StatusBarColorScheme

    public func body(content: Content) -> some View {
        content.overlay {
            if let device {
                // Status Bar
                VStack {
                    SimulatedStatusBar(device: device, scheme: statusBarColorScheme)
                    Spacer()
                }
                .ignoresSafeArea(.all)

                // Home Indicator if any
                if let homeIndicator = device.homeIndicator {
                    VStack {
                        Spacer()
                        SimulatedHomeIndicator(homeIndicator: homeIndicator, scheme: homeIndicatorColorScheme)
                    }
                    .ignoresSafeArea(.all)
                }
            }
        }
    }
}

extension View {
    @available(iOS 16.0, *)
    public func withSystemDecoration(
        homeIndicator: HomeIndicatorColorScheme = .inherit,
        statusBar: StatusBarColorScheme = .inherit
    ) -> some View {
        modifier(WithSystemDecorationModifier(
            homeIndicatorColorScheme: homeIndicator,
            statusBarColorScheme: statusBar
        ))
    }
}
