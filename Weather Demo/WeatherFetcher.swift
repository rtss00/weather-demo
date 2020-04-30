//
//  WeatherFetcher.swift
//  Weather Demo
//
//  Created by eagerworks 2 on 4/22/20.
//  Copyright © 2020 eagerWorks. All rights reserved.
//

import Foundation

enum WeatherFetcher {
  private static let apiKey = "3facda65b3da9h0h73a2cd751fa701a7" // Not a real key! Replace it with yours

  // Facilitates decoding, for talk time purposes
  private struct MultiCityDecodable: Codable {
    let cnt: Int
    let list: [CityWeather]
  }

  // This way because the multicity API endpoint is broken
  static func getCurrent(for cities: [String], completion: @escaping (Result<[CityWeather], Error>) -> Void) {
    var citiesFound: [CityWeather] = []
    var tasks: [URLSessionDataTask] = []

    for city in cities {
      let urlString = "https://api.openweathermap.org/data/2.5/weather?q=\(city)&appid=\(apiKey)"
      let url = URL(string: urlString)!
      let task = URLSession.shared.dataTask(with: url) { data, response, error in
        guard let data = data else {
          let error: Error = error ?? FetchingError.noDataFound
          completion(.failure(error))
          tasks.forEach { task in task.cancel() }
          return
        }

        do {
          let decoder = JSONDecoder()
          let cityWeather = try decoder.decode(CityWeather.self, from: data)
          citiesFound.append(cityWeather)

          if citiesFound.count == cities.count {
            completion(.success(citiesFound))
          }
        } catch {
          completion(.failure(FetchingError.decodingFailed))
          tasks.forEach { task in task.cancel() }
        }
      }

      tasks.append(task)
      task.resume()
    }
  }


  enum FetchingError: Error {
    case noDataFound
    case decodingFailed
  }
}
