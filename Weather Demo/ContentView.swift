//
//  ContentView.swift
//  Weather Demo
//
//  Created by eagerworks 2 on 4/22/20.
//  Copyright © 2020 eagerWorks. All rights reserved.
//

import SwiftUI

struct ContentView: View {
  @ObservedObject var weatherLoader: WeatherLoader

  var body: some View {
    NavigationView {
      if weatherLoader.weathers.isEmpty {
        Text("loading...")
      } else {
        List {
          ForEach(weatherLoader.weathers, id: \.self) { weather in
            WeatherCell(cityWeather: weather)
          }
        }.navigationBarTitle("Weather ⛅️", displayMode: .large)
      }
    }
  }
}

struct ContentView_Previews: PreviewProvider {
  static var previews: some View {
    let previewWeatherLoader = WeatherLoader()

    return ContentView(weatherLoader: previewWeatherLoader)
  }
}
