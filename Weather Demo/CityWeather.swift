//
//  CitiWeather.swift
//  Weather Demo
//
//  Created by eagerworks 2 on 4/22/20.
//  Copyright © 2020 eagerWorks. All rights reserved.
//

import Foundation

struct CityWeather: Codable, Hashable {
  // Used to avoid dict decoding w/ multiple target types
  struct Weather: Codable, Hashable {
    let main: String
    let description: String
    let icon: String
  }

  let name: String
  let main: [String: Double]
  let weather: [Weather]

  // icon translator
  static func icon(for value: String) -> String {
    switch value {
    case "01d":
      return "☀️"
    case "02d":
      return "⛅️"
    case "03d":
      return "☁️"
    case "04d":
      return "🌤"
    case "09d":
      return "🌦"
    case "10d":
      return "🌧"
    case "11d":
      return "⛈"
    case "13d":
      return "🌨"
    case "50d":
      return "🌫"
    default:
      return "☀️"
    }
  }
}

// kelvni to celsius
extension Double {
  var kelvin: Double { self - 273.15 }
}
