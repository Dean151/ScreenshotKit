//
//  Interface.swift
//

public enum ScreenshotType {
    /// Fit the result view before generating the screenshot at the appropriate size
    case sizeThatFits
    /// Fix the result screenshot size at the specified size
    case fixed(width: Double, height: Double)
    /// Match the specified device
    case device(_ device: SimulatedDeviceType)
    /// Match all specified devices
    case devices(_ devices: [SimulatedDeviceType])
}

public struct ScreenshotColorSchemes: OptionSet {
    public let rawValue: UInt

    public static let light = ScreenshotColorSchemes(rawValue: 1 << 0)
    public static let dark = ScreenshotColorSchemes(rawValue: 1 << 1)
    public static let all: ScreenshotColorSchemes = [.light, .dark]

    public init(rawValue: UInt) {
        self.rawValue = rawValue
    }
}

public enum SimulatedDeviceType {
    /// Generate for all iPhones sizes
    case iPhone(orientations: SimulatedDeviceOrientations)
    /// Generate for all iPad sizes
    case iPad(orientations: SimulatedDeviceOrientations)
}

public struct SimulatedDeviceOrientations: OptionSet {
    public let rawValue: UInt

    public static let portrait = SimulatedDeviceOrientations(rawValue: 1 << 0)
    public static let landscape = SimulatedDeviceOrientations(rawValue: 1 << 1)
    public static let all: SimulatedDeviceOrientations = [.portrait, .landscape]

    public init(rawValue: UInt) {
        self.rawValue = rawValue
    }
}
