//
//  Network.swift
//  project2-
//
//  Created by Alanoud  on 04/02/1445 AH.
//

import Foundation


class NetworkManager {
    static let shared = NetworkManager()

    private let apiKey = "bac75388d50e1a554941601bad195a20" // Replace with your OpenWeatherMap API key
    private let baseUrl = "https://api.openweathermap.org/data/2.5/weather"

    func fetchWeather(for city: String, completion: @escaping (Result<WeatherData, Error>) -> Void) {
        let urlString = "\(baseUrl)?q=\(city)&appid=\(apiKey)&units=metric"
        if let url = URL(string: urlString) {
            URLSession.shared.dataTask(with: url) { data, response, error in
                if let error = error {
                    completion(.failure(error))
                    return
                }

                if let data = data {
                    do {
                        let decoder = JSONDecoder()
                        decoder.keyDecodingStrategy = .convertFromSnakeCase
                        let weatherData = try decoder.decode(WeatherData.self, from: data)
                        completion(.success(weatherData))
                    } catch {
                        completion(.failure(error))
                    }
                }
            }.resume()
        }
    }
}
