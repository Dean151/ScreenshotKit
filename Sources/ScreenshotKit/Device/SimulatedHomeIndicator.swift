//
//  SimulatedHomeIndicator.swift
//

import SwiftUI

struct HomeIndicator {
    let size: CGSize
    let bottom: Double
}

public enum HomeIndicatorColorScheme {
    case inherit, light, dark

    var colorScheme: ColorScheme? {
        switch self {
        case .inherit:
            return .none
        case .light:
            return .light
        case .dark:
            return .dark
        }
    }
}

struct SimulatedHomeIndicator: View {
    let homeIndicator: HomeIndicator
    let scheme: HomeIndicatorColorScheme

    var body: some View {
        HStack {
            Spacer()
            Capsule()
                .frame(width: homeIndicator.size.width, height: homeIndicator.size.height)
            Spacer()
        }
        .padding(.bottom, homeIndicator.bottom)
        .preferredColorScheme(scheme.colorScheme)
    }
}
