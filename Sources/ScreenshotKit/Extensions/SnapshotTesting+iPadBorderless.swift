//
//  SnapshotTesting+iPadBorderless.swift
//

#if os(iOS)
import UIKit
import SnapshotTesting

extension ViewImageConfig {
    public static let iPadPro12_9Borderless = ViewImageConfig.iPadPro12_9Borderless(.landscape)

    public static func iPadPro12_9Borderless(_ orientation: Orientation) -> ViewImageConfig {
      switch orientation {
      case .landscape:
        return ViewImageConfig.iPadPro12_9Borderless(.landscape(splitView: .full))
      case .portrait:
        return ViewImageConfig.iPadPro12_9Borderless(.portrait(splitView: .full))
      }
    }

    public static func iPadPro12_9Borderless(_ orientation: TabletOrientation) -> ViewImageConfig {
      let size: CGSize
      let traits: UITraitCollection
      switch orientation {
      case .landscape(let splitView):
        switch splitView {
        case .oneThird:
          size = .init(width: 375, height: 1024)
          traits = .iPadPro12_9_Compact_SplitView
        case .oneHalf:
          size = .init(width: 678, height: 1024)
          traits = .iPadPro12_9
        case .twoThirds:
          size = .init(width: 981, height: 1024)
          traits = .iPadPro12_9
        case .full:
          size = .init(width: 1366, height: 1024)
          traits = .iPadPro12_9
        }

      case .portrait(let splitView):
        switch splitView {
        case .oneThird:
          size = .init(width: 375, height: 1366)
          traits = .iPadPro12_9_Compact_SplitView
        case .twoThirds:
          size = .init(width: 639, height: 1366)
          traits = .iPadPro12_9_Compact_SplitView
        case .full:
          size = .init(width: 1024, height: 1366)
          traits = .iPadPro12_9
        }
      }
      return .init(safeArea: .init(top: 24, left: 0, bottom: 20, right: 0), size: size, traits: traits)
    }
}

#endif
