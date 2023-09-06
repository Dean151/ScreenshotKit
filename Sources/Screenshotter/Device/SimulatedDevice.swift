//
//  SimulatedDevice.swift
//

import SwiftUI

import SnapshotTesting

enum SimulatedDeviceOrientation {
    case portrait, landscape

    var configOrientation: ViewImageConfig.Orientation {
        switch self {
        case .portrait:
            return .portrait
        case .landscape:
            return .landscape
        }
    }
}

enum ScreenshotColorScheme: String, CaseIterable {
    case light
    case dark

    var userInterfaceStyle: UIUserInterfaceStyle {
        switch self {
        case .light:
            return .light
        case .dark:
            return .dark
        }
    }
}

struct SimulatedDeviceEnvironmentKey: EnvironmentKey {
    static let defaultValue: SimulatedDevice? = .init()
}
extension EnvironmentValues {
    var device: SimulatedDevice? {
        get {
            return self[SimulatedDeviceEnvironmentKey.self]
        }
        set {
            self[SimulatedDeviceEnvironmentKey.self] = newValue
        }
    }
}

enum SimulatedDevice: Hashable, CustomStringConvertible {
    case iPhone8(_ orientation: SimulatedDeviceOrientation)
    case iPhone8Plus(_ orientation: SimulatedDeviceOrientation)
    case iPhone14(_ orientation: SimulatedDeviceOrientation)
    case iPhone14Plus(_ orientation: SimulatedDeviceOrientation)
    case iPhone14Pro(_ orientation: SimulatedDeviceOrientation)
    case iPhone14ProMax(_ orientation: SimulatedDeviceOrientation)
    case iPadPro12_9HomeButton(_ orientation: SimulatedDeviceOrientation)
    case iPadPro12_9(_ orientation: SimulatedDeviceOrientation)
    case iPadPro11(_ orientation: SimulatedDeviceOrientation)

    var description: String {
        switch self {
        case .iPhone8(let orientation):
            return "iPhone8-\(orientation)"
        case .iPhone8Plus(let orientation):
            return "iPhone8Plus-\(orientation)"
        case .iPhone14(let orientation):
            return "iPhone14-\(orientation)"
        case .iPhone14Plus(let orientation):
            return "iPhone14Plus-\(orientation)"
        case .iPhone14Pro(let orientation):
            return "iPhone14Pro-\(orientation)"
        case .iPhone14ProMax(let orientation):
            return "iPhone14ProMax-\(orientation)"
        case .iPadPro12_9HomeButton(let orientation):
            return "iPadPro12_9HomeButton-\(orientation)"
        case .iPadPro12_9(let orientation):
            return "iPadPro12_9-\(orientation)"
        case .iPadPro11(let orientation):
            return "iPadPro11-\(orientation)"
        }
    }

    var config: ViewImageConfig {
        switch self {
        case .iPhone8(let orientation):
            return .iPhone8(orientation.configOrientation)
        case .iPhone8Plus(let orientation):
            return .iPhone8Plus(orientation.configOrientation)
        case .iPhone14(let orientation):
            return .iPhone14(orientation.configOrientation)
        case .iPhone14Plus(let orientation):
            return .iPhone14Plus(orientation.configOrientation)
        case .iPhone14Pro(let orientation):
            return .iPhone14Pro(orientation.configOrientation)
        case .iPhone14ProMax(let orientation):
            return .iPhone14ProMax(orientation.configOrientation)
        case .iPadPro12_9HomeButton(let orientation):
            return .iPadPro12_9(orientation.configOrientation)
        case .iPadPro12_9(let orientation):
            return .iPadPro12_9Borderless(orientation.configOrientation)
        case .iPadPro11(let orientation):
            return .iPadPro11(orientation.configOrientation)
        }
    }

    var scale: Double {
        switch self {
        case .iPhone8, .iPadPro12_9HomeButton, .iPadPro12_9, .iPadPro11:
            return 2
        case.iPhone8Plus, .iPhone14, .iPhone14Plus, .iPhone14Pro, .iPhone14ProMax:
            return 3
        }
    }

    var statusBar: StatusBar {
        switch self {
        case .iPhone8, .iPhone8Plus:
            return .init(layout: .legacy, leading: 6, trailing: 2, mainFont: .footnote, timeFont: .footnote.weight(.semibold), batteryFont: .subheadline)
        case .iPhone14:
            return .init(layout: .notched, top: 2.5, leading: 38, trailing: 16, mainFont: .footnote, timeFont: .callout.weight(.bold), batteryFont: .subheadline)
        case .iPhone14Plus:
            return .init(layout: .notched, scale: 1.1, top: 1.5, leading: 50, trailing: 28, mainFont: .footnote, timeFont: .callout.weight(.semibold), batteryFont: .subheadline)
        case .iPhone14Pro:
            return .init(layout: .notched, scale: 1.1, top: -1, leading: 56, trailing: 34, mainFont: .footnote, timeFont: .callout.weight(.semibold), batteryFont: .subheadline)
        case .iPhone14ProMax:
            return .init(layout: .notched, scale: 1.2, top: -1, leading: 64, trailing: 42, mainFont: .footnote, timeFont: .callout.weight(.bold), batteryFont: .subheadline)
        case .iPadPro12_9HomeButton:
            return .init(layout: .iPad, leading: 4.5, trailing: 2.5, mainFont: .footnote, timeFont: .footnote.weight(.semibold), batteryFont: .subheadline)
        case .iPadPro12_9, .iPadPro11:
            return .init(layout: .iPad, leading: 14, trailing: 13.5, mainFont: .footnote, timeFont: .footnote.weight(.semibold), batteryFont: .subheadline)
        }
    }

    var homeIndicator: HomeIndicator? {
        switch self {
        case .iPhone8:
            return nil
        case .iPhone8Plus:
            return nil
        case .iPhone14:
            return .init(size: .init(width: 139, height: 5), bottom: 8)
        case .iPhone14Plus:
            return .init(size: .init(width: 153, height: 5), bottom: 8)
        case .iPhone14Pro:
            return .init(size: .init(width: 140, height: 5), bottom: 8)
        case .iPhone14ProMax:
            return .init(size: .init(width: 154, height: 5), bottom: 8)
        case .iPadPro12_9HomeButton:
            return nil
        case .iPadPro12_9(let orientation):
            switch orientation {
            case .landscape:
                return .init(size: .init(width: 345, height: 5.5), bottom: 7.5)
            case .portrait:
                return .init(size: .init(width: 315, height: 5.5), bottom: 7.5)
            }
        case .iPadPro11(let orientation):
            switch orientation {
            case .landscape:
                return .init(size: .init(width: 315, height: 5.5), bottom: 7.5)
            case .portrait:
                return .init(size: .init(width: 273, height: 5.5), bottom: 7.5)
            }
        }
    }

    init?() {
        guard let device = SimulatedDevice.allCases.first(where: { $0.config.size == UIScreen.main.bounds.size }) else {
            return nil
        }
        self = device
    }
}

extension SimulatedDevice: CaseIterable {
    static var allCases: [SimulatedDevice] {
        return SimulatedDeviceOrientations.all.each.flatMap({
            [
                .iPhone8($0),
                .iPhone8Plus($0),
                .iPhone14($0),
                .iPhone14Plus($0),
                .iPhone14Pro($0),
                .iPhone14ProMax($0),
                .iPadPro12_9($0),
                .iPadPro12_9HomeButton($0),
                .iPadPro11($0),
            ]
        })
    }

    static func matching(type: SimulatedDeviceType) -> [SimulatedDevice] {
        switch type {
        case .iPhone(let orientations):
            return orientations.each.flatMap { [
                .iPhone8($0),
                .iPhone8Plus($0),
                .iPhone14($0),
                .iPhone14Plus($0),
                .iPhone14Pro($0),
                .iPhone14ProMax($0)
            ] }
        case .iPad(let orientations):
            return orientations.each.flatMap { [
                .iPadPro12_9($0),
                .iPadPro12_9HomeButton($0),
                .iPadPro11($0)
            ] }
        }
    }
}

// MARK: Enumerators

extension ScreenshotType {
    func each(_ callback: (SwiftUISnapshotLayout, SimulatedDevice) throws -> Void) rethrows {
        switch self {
        case .sizeThatFits:
            try callback(.sizeThatFits, .iPhone14Pro(.portrait))
        case .fixed(let width, let height):
            try callback(.fixed(width: width, height: height), .iPhone14Pro(.portrait))
        case .device(let device):
            try ScreenshotType.devices([device]).each(callback)
        case .devices(let devices):
            for deviceType in devices {
                for device in SimulatedDevice.matching(type: deviceType) {
                    try callback(.device(config: device.config), device)
                }
            }
        }
    }
}

extension SimulatedDeviceOrientations {
    var each: [SimulatedDeviceOrientation] {
        var orientations: [SimulatedDeviceOrientation] = []
        if contains(.portrait) {
            orientations.append(.portrait)
        }
        if contains(.landscape) {
            orientations.append(.landscape)
        }
        return orientations
    }
}

extension ScreenshotColorSchemes {
    var each: [ScreenshotColorScheme] {
        var schemes: [ScreenshotColorScheme] = []
        if contains(.light) {
            schemes.append(.light)
        }
        if contains(.dark) {
            schemes.append(.dark)
        }
        return schemes
    }
}
