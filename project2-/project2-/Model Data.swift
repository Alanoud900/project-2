//
//  Model Data.swift
//  project2-
//
//  Created by Alanoud  on 04/02/1445 AH.
//

import Foundation


struct WeatherData: Codable {
    let main: Main
    let weather: [Weather]
    let sys: Sys
}

struct Main: Codable {
    let temp: Double
    let feelsLike: Double?
    let tempMin: Double
    let tempMax: Double
    let pressure: Double
    let humidity: Int
    let seaLevel: Double?
    let grndLevel: Double?
}

struct Weather: Codable {
    let description: String
}

struct Sys: Codable {
    let sunrise: Int
    let sunset: Int
}
