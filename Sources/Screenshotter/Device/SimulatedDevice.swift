//
//  SimulatedDevice.swift
//

import SwiftUI

import SnapshotTesting

public enum SimulatedDeviceType {
    case iPhone
    case iPad
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

public struct SimulatedDeviceOrientations: OptionSet {
    public let rawValue: UInt

    public static let portrait = SimulatedDeviceOrientations(rawValue: 1 << 0)
    public static let landscape = SimulatedDeviceOrientations(rawValue: 1 << 1)
    public static let all: SimulatedDeviceOrientations = [.portrait, .landscape]

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

    public init(rawValue: UInt) {
        self.rawValue = rawValue
    }
}

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

    var type: SimulatedDeviceType {
        switch self {
        case .iPhone8, .iPhone8Plus, .iPhone14, .iPhone14Plus, .iPhone14Pro, .iPhone14ProMax:
            return .iPhone
        case .iPadPro12_9HomeButton, .iPadPro12_9, .iPadPro11:
            return .iPad
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
        return [
            .iPhone8(.portrait),
            .iPhone8(.landscape),
            .iPhone8Plus(.portrait),
            .iPhone8Plus(.landscape),
            .iPhone14(.portrait),
            .iPhone14(.landscape),
            .iPhone14Plus(.portrait),
            .iPhone14Plus(.landscape),
            .iPhone14Pro(.portrait),
            .iPhone14Pro(.landscape),
            .iPhone14ProMax(.portrait),
            .iPhone14ProMax(.landscape),
            .iPadPro12_9(.landscape),
            .iPadPro12_9(.portrait),
            .iPadPro12_9HomeButton(.landscape),
            .iPadPro12_9HomeButton(.portrait),
            .iPadPro11(.landscape),
            .iPadPro11(.portrait)
        ]
    }

    static func matching(type: SimulatedDeviceType, orientation: SimulatedDeviceOrientation? = nil, screenScale: CGFloat) -> [SimulatedDevice] {
        switch type {
        case .iPhone:
            switch screenScale {
            case 2:
                return [.iPhone8(orientation ?? .portrait)]
            case 3:
                return [
                    .iPhone8Plus(orientation ?? .portrait),
                    .iPhone14(orientation ?? .portrait),
                    .iPhone14Plus(orientation ?? .portrait),
                    .iPhone14Pro(orientation ?? .portrait),
                    .iPhone14ProMax(orientation ?? .portrait)
                ]
            default:
                return []
            }
        case .iPad:
            guard screenScale == 2 else {
                return []
            }
            return [
                .iPadPro12_9(orientation ?? .landscape),
                .iPadPro12_9HomeButton(orientation ?? .landscape),
                .iPadPro11(orientation ?? .landscape)
            ]
        }
    }
}
