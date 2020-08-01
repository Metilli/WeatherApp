//
//  WeatherData.swift
//  WeatherApp
//
//  Created by Metilli on 31.07.2020.
//  Copyright © 2020 Mac. All rights reserved.
//

import Foundation

struct WeatherData: Codable{
    let name: String
    let main: Main
    let weather: [Weather]
}

struct Weather: Codable{
    let id: Int
    let description: String
}

struct Main: Codable {
    let temp: Double
    let humidity: Double
}
