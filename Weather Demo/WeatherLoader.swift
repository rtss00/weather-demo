//
//  WeatherLoader.swift
//  Weather Demo
//
//  Created by eagerworks 2 on 4/22/20.
//  Copyright © 2020 eagerWorks. All rights reserved.
//

import Foundation

class WeatherLoader: ObservableObject {
  @Published var weathers: [CityWeather] = []

  init() {
    load()
  }

  func load() {
    WeatherFetcher.getCurrent(for: ["London,uk", "Montevideo,uy", "Manhattan,us", "Madrid,es"]) { result in
      switch result {
      case .failure(let error):
        print(error)
      case .success(let weathers):
        DispatchQueue.main.async {
          self.weathers = weathers
        }
      }
    }
  }
}
