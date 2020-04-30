//
//  WeatherCell.swift
//  Weather Demo
//
//  Created by eagerworks 2 on 4/22/20.
//  Copyright © 2020 eagerWorks. All rights reserved.
//

import SwiftUI

struct WeatherCell: View {
  @State var cityWeather: CityWeather

  var body: some View {
    // Params used in view, from cityWeather
    let cityName = cityWeather.name
    let description = cityWeather.weather[0].description.capitalized
    let temperature = Int(cityWeather.main["temp"]?.kelvin ?? 0)

    return HStack {
      VStack(alignment: .leading) {
        Text(cityName)
          .font(Font.system(size: 25, weight: .semibold, design: .default))
        Text(description)
      }
      Spacer()
      Text(CityWeather.icon(for: cityWeather.weather[0].icon))
        .font(Font.system(size: 50))
      Text("\(temperature)°C")
        .font(Font.system(size: 30))
    }.padding()
  }
}

struct WeatherCell_Previews: PreviewProvider {
  static var previews: some View {
    let testWeather = CityWeather(
      name: "Cupertino",
      main: [
        "temp": 280.32
      ],
      weather: [
        CityWeather.Weather(
          main: "Drizzle",
          description: "light intensity drizzle",
          icon: "09d"
        )
      ]
    )

    return WeatherCell(cityWeather: testWeather)
  }
}
