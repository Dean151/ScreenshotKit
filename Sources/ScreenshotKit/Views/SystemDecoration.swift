//
//  SystemDecoration.swift
//
//  Created by Thomas Durand on 23/08/2023.
//  Copyright © 2023 Illumineering. All rights reserved.
//

#if os(iOS)

import SwiftUI

@available(iOS 17, *)
public struct WithSystemDecorationModifier: ViewModifier {
    @Environment(\.device)
    private var device

    let homeIndicatorColorScheme: HomeIndicatorColorScheme
    let statusBarColorScheme: StatusBarColorScheme

    public func body(content: Content) -> some View {
        content
            .safeAreaPadding(.top, device?.config.safeArea.top ?? 0)
            .safeAreaPadding(.bottom, device?.config.safeArea.bottom ?? 0)
            .overlay {
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

@available(iOS 17, *)
extension View {
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

#endif
