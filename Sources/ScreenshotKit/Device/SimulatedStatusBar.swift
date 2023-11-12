//
//  SimulatedStatusBar.swift
//

import SwiftUI

struct StatusBar {
    enum Layout {
        case legacy
        case notched
        case iPad
    }
    let layout: Layout
    let scale: Double
    let top: CGFloat
    let leading: CGFloat
    let trailing: CGFloat
    let mainFont: Font
    let timeFont: Font
    let batteryFont: Font

    init(layout: Layout, scale: Double = 1, top: CGFloat = 0, leading: CGFloat, trailing: CGFloat, mainFont: Font, timeFont: Font, batteryFont: Font) {
        self.layout = layout
        self.scale = scale
        self.top = top
        self.leading = leading
        self.trailing = trailing
        self.mainFont = mainFont
        self.timeFont = timeFont
        self.batteryFont = batteryFont
    }
}

public enum StatusBarColorScheme {
    case inherit, light, dark
    #warning("TODO: support iOS 17 splitted status bar style")

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

struct SimulatedStatusBar: View {
    let device: SimulatedDevice
    let scheme: StatusBarColorScheme

    var body: some View {
        switch device.statusBar.layout {
        case .legacy:
            SimulatedNotchlessStatusBar(statusBar: device.statusBar)
                .frame(height: device.config.safeArea.top)
                .preferredColorScheme(scheme.colorScheme)
        case .notched:
            SimulatedNotchStatusBar(statusBar: device.statusBar)
                .frame(height: device.config.safeArea.top)
                .preferredColorScheme(scheme.colorScheme)
        case .iPad:
            SimulatediPadStatusBar(statusBar: device.statusBar)
                .frame(height: device.config.safeArea.top)
                .preferredColorScheme(scheme.colorScheme)
        }
    }
}

struct SimulatedNotchlessStatusBar: View {
    let statusBar: StatusBar

    var body: some View {
        ZStack {
            HStack(spacing: 2) {
                Image(systemName: "cellularbars")
                Image(systemName: "wifi")
                    .fontWeight(.black)
                Spacer()
            }

            HStack(spacing: 2) {
                Spacer()
                Text("\(100, format: .percent)")
                Image(systemName: "battery.100")
                    .imageScale(.large)
                    .font(statusBar.batteryFont)
                    .foregroundStyle(.foreground, .gray)
            }

            Text("\(Date.nineFortyOne, formatter: DateFormatter.shortTime)")
                .font(statusBar.timeFont)
        }
        .font(statusBar.mainFont)
        .padding(.top, statusBar.top)
        .padding(.leading, statusBar.leading)
        .padding(.trailing, statusBar.trailing)
    }
}

struct SimulatedNotchStatusBar: View {
    let statusBar: StatusBar

    var body: some View {
        ZStack {
            HStack {
                Text("\(Date.nineFortyOne, formatter: DateFormatter.minimalTime)")
                    .font(statusBar.timeFont)
                    .scaleEffect(x: statusBar.scale, y: statusBar.scale)
                Spacer()
            }

            HStack {
                Spacer()
                HStack(spacing: 3) {
                    Image(systemName: "cellularbars")
                    Image(systemName: "wifi")
                        .fontWeight(.black)
                    Image(systemName: "battery.100")
                        .imageScale(.large)
                        .font(statusBar.batteryFont)
                        .foregroundStyle(.foreground, .gray)
                }
                .scaleEffect(x: statusBar.scale, y: statusBar.scale)
            }
        }
        .font(statusBar.mainFont)
        .padding(.top, statusBar.top)
        .padding(.leading, statusBar.leading)
        .padding(.trailing, statusBar.trailing)
    }
}

struct SimulatediPadStatusBar: View {
    let statusBar: StatusBar

    var body: some View {
        ZStack {
            HStack(spacing: 9) {
                Text("\(Date.nineFortyOne, formatter: DateFormatter.shortTime)")
                    .font(statusBar.timeFont)

                Text("\(Date.nineFortyOne, formatter: DateFormatter.date)")
                    .font(statusBar.timeFont)

                Spacer()
            }

            HStack(spacing: 2) {
                Spacer()
                Image(systemName: "wifi")
                    .fontWeight(.black)
                Text("\(100, format: .percent)")
                Image(systemName: "battery.100")
                    .imageScale(.large)
                    .font(statusBar.batteryFont)
                    .foregroundStyle(.foreground, .gray)
            }

            Image(systemName: "ellipsis")
                .imageScale(.small)
                .foregroundStyle(.secondary)
                .font(.title)
        }
        .font(statusBar.mainFont)
        .padding(.top, statusBar.top)
        .padding(.leading, statusBar.leading)
        .padding(.trailing, statusBar.trailing)
    }
}

extension Date {
    static var nineFortyOne: Date {
        var components = DateComponents(calendar: .current, timeZone: .current)
        components.year = 2007
        components.month = 1
        components.day = 9
        components.hour = 9
        components.minute = 41
        return components.date.unsafelyUnwrapped
    }
}

extension DateFormatter {
    static var date: DateFormatter {
        let formatter = DateFormatter()
        formatter.setLocalizedDateFormatFromTemplate("E MMM d")
        return formatter
    }
    static var shortTime: DateFormatter {
        let formatter = DateFormatter()
        formatter.dateStyle = .none
        formatter.timeStyle = .short
        return formatter
    }
    static var minimalTime: DateFormatter {
        let formatter = DateFormatter()
        formatter.dateStyle = .none
        formatter.timeStyle = .short
        formatter.amSymbol = ""
        formatter.pmSymbol = ""
        return formatter
    }
}
