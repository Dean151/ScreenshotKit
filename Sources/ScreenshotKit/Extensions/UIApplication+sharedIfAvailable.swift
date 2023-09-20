//
//  UIApplication+sharedIfAvailable.swift
//

import UIKit

extension UIApplication {
    static var sharedIfAvailable: UIApplication? {
      let sharedSelector = NSSelectorFromString("sharedApplication")
      guard UIApplication.responds(to: sharedSelector) else {
        return nil
      }

      let shared = UIApplication.perform(sharedSelector)
      return (shared?.takeUnretainedValue() as? UIApplication?).unsafelyUnwrapped
  }
}
