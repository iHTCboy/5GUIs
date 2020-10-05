//
//  DetectedTechnologies.swift
//  5GUIs
//
//  Created by Helge Heß on 05.10.20.
//

struct DetectedTechnologies: OptionSet {
  let rawValue : UInt64

  static let electron  = DetectedTechnologies(rawValue: 1 << 1)
  static let catalyst  = DetectedTechnologies(rawValue: 1 << 2)
  static let swiftui   = DetectedTechnologies(rawValue: 1 << 3)
  static let uikit     = DetectedTechnologies(rawValue: 1 << 4)
  static let appkit    = DetectedTechnologies(rawValue: 1 << 5)
  static let qt        = DetectedTechnologies(rawValue: 1 << 6)
  static let wxWidgets = DetectedTechnologies(rawValue: 1 << 7)

  static let objc      = DetectedTechnologies(rawValue: 1 << 10)
  static let swift     = DetectedTechnologies(rawValue: 1 << 11)
  static let cplusplus = DetectedTechnologies(rawValue: 1 << 12)
  static let python    = DetectedTechnologies(rawValue: 1 << 13)
  static let java      = DetectedTechnologies(rawValue: 1 << 14)

  static let carbon    = DetectedTechnologies(rawValue: 1 << 42)
}

extension DetectedTechnologies {
  
  mutating func scanDependencies(_ dependencies: [ String ]) {
    for dep in dependencies {
      func check(_ option: DetectedTechnologies, _ needle: String) -> Bool
      {
        guard !contains(option)    else { return false } // scanned already
        guard dep.contains(needle) else { return false }
        self.insert(option)
        return true
      }
      
      if check(.electron,  "Electron")          { continue }
      if check(.catalyst,  "UIKitMacHelper")    { continue }
      if check(.appkit,    "AppKit.framework")  { continue }
      if check(.swiftui,   "SwiftUI.framework") { continue }
      if check(.uikit,     "UIKit.framework")   { continue }
      if check(.qt,        "QtCore.framework")  { continue }
      
      if check(.cplusplus, "libc++")            { continue }
      if check(.objc,      "libobjc")           { continue }
      if check(.swift,     "libswiftCore")      { continue }
    }
  }
}
