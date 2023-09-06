//
//  SnapshotTesting+iPhone14.swift
//

import UIKit

import SnapshotTesting

extension ViewImageConfig {
    public static let iPhone14 = ViewImageConfig.iPhone14(.portrait)

    public static func iPhone14(_ orientation: Orientation) -> ViewImageConfig {
        let safeArea: UIEdgeInsets
        let size: CGSize
        switch orientation {
        case .landscape:
            safeArea = .init(top: 0, left: 47, bottom: 21, right: 47)
            size = .init(width: 844, height: 390)
        case .portrait:
            safeArea = .init(top: 47, left: 0, bottom: 34, right: 0)
            size = .init(width: 390, height: 844)
        }

        return .init(safeArea: safeArea, size: size, traits: .iPhone14(orientation))
    }
}

extension ViewImageConfig {
     public static let iPhone14Plus = ViewImageConfig.iPhone14Plus(.portrait)

     public static func iPhone14Plus(_ orientation: Orientation) -> ViewImageConfig {
       let safeArea: UIEdgeInsets
       let size: CGSize
       switch orientation {
       case .landscape:
         safeArea = .init(top: 0, left: 47, bottom: 21, right: 47)
         size = .init(width: 926, height: 428)
       case .portrait:
         safeArea = .init(top: 47, left: 0, bottom: 34, right: 0)
         size = .init(width: 428, height: 926)
       }

       return .init(safeArea: safeArea, size: size, traits: .iPhone14Plus(orientation))
     }
}

extension ViewImageConfig {
     public static let iPhone14Pro = ViewImageConfig.iPhone14Pro(.portrait)

     public static func iPhone14Pro(_ orientation: Orientation) -> ViewImageConfig {
       let safeArea: UIEdgeInsets
       let size: CGSize
       switch orientation {
       case .landscape:
         safeArea = .init(top: 0, left: 59, bottom: 21, right: 59)
         size = .init(width: 852, height: 393)
       case .portrait:
         safeArea = .init(top: 59, left: 0, bottom: 34, right: 0)
          size = .init(width: 393, height: 852)
       }

       return .init(safeArea: safeArea, size: size, traits: .iPhone14Pro(orientation))
     }
}

extension ViewImageConfig {
     public static let iPhone14ProMax = ViewImageConfig.iPhone14ProMax(.portrait)

     public static func iPhone14ProMax(_ orientation: Orientation) -> ViewImageConfig {
       let safeArea: UIEdgeInsets
       let size: CGSize
       switch orientation {
       case .landscape:
         safeArea = .init(top: 0, left: 59, bottom: 21, right: 59)
         size = .init(width: 932, height: 430)
       case .portrait:
         safeArea = .init(top: 59, left: 0, bottom: 34, right: 0)
         size = .init(width: 430, height: 932)
       }

       return .init(safeArea: safeArea, size: size, traits: .iPhone14ProMax(orientation))
     }
}

extension UITraitCollection {
    public static func iPhone14(_ orientation: ViewImageConfig.Orientation) -> UITraitCollection {
      let base: [UITraitCollection] = [
        .init(forceTouchCapability: .available),
        .init(layoutDirection: .leftToRight),
        .init(preferredContentSizeCategory: .medium),
        .init(userInterfaceIdiom: .phone)
      ]
      switch orientation {
      case .landscape:
        return .init(
          traitsFrom: base + [
            .init(horizontalSizeClass: .regular),
            .init(verticalSizeClass: .compact)
          ]
        )
      case .portrait:
        return .init(
          traitsFrom: base + [
            .init(horizontalSizeClass: .compact),
            .init(verticalSizeClass: .regular)
          ]
        )
      }
    }

    public static func iPhone14Plus(_ orientation: ViewImageConfig.Orientation) -> UITraitCollection {
      let base: [UITraitCollection] = [
        .init(forceTouchCapability: .available),
        .init(layoutDirection: .leftToRight),
        .init(preferredContentSizeCategory: .medium),
        .init(userInterfaceIdiom: .phone)
      ]
      switch orientation {
      case .landscape:
        return .init(
          traitsFrom: base + [
            .init(horizontalSizeClass: .regular),
            .init(verticalSizeClass: .compact)
          ]
        )
      case .portrait:
        return .init(
          traitsFrom: base + [
            .init(horizontalSizeClass: .compact),
            .init(verticalSizeClass: .regular)
          ]
        )
      }
    }

    public static func iPhone14Pro(_ orientation: ViewImageConfig.Orientation) -> UITraitCollection {
      let base: [UITraitCollection] = [
        .init(forceTouchCapability: .available),
        .init(layoutDirection: .leftToRight),
        .init(preferredContentSizeCategory: .medium),
        .init(userInterfaceIdiom: .phone)
      ]
      switch orientation {
      case .landscape:
        return .init(
          traitsFrom: base + [
            .init(horizontalSizeClass: .regular),
            .init(verticalSizeClass: .compact)
          ]
        )
      case .portrait:
        return .init(
          traitsFrom: base + [
            .init(horizontalSizeClass: .compact),
            .init(verticalSizeClass: .regular)
          ]
        )
      }
    }

    public static func iPhone14ProMax(_ orientation: ViewImageConfig.Orientation) -> UITraitCollection {
      let base: [UITraitCollection] = [
        .init(forceTouchCapability: .available),
        .init(layoutDirection: .leftToRight),
        .init(preferredContentSizeCategory: .medium),
        .init(userInterfaceIdiom: .phone)
      ]
      switch orientation {
      case .landscape:
        return .init(
          traitsFrom: base + [
            .init(horizontalSizeClass: .regular),
            .init(verticalSizeClass: .compact)
          ]
        )
      case .portrait:
        return .init(
          traitsFrom: base + [
            .init(horizontalSizeClass: .compact),
            .init(verticalSizeClass: .regular)
          ]
        )
      }
    }
}
