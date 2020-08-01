//
//  WeatherModel.swift
//  WeatherApp
//
//  Created by Metilli on 31.07.2020.
//  Copyright © 2020 Mac. All rights reserved.
//

import Foundation

struct WeatherModel{
    let conditionID: Int
    let cityName: String
    let temperature: Double
    let humidity: Double
    let weatherDescription: String
    
    var temperatureString: String{
        let roundedTemp = (String(format: "%.1f",temperature.round(to: 1)))
        return "\(roundedTemp) °C"
    }
    var humidityString: String{
        let roundedHumidity = String(format: "%.1f", humidity.round(to: 0))
        return "\(roundedHumidity) %"
    }
    var weatherImage: String{
        switch conditionID {
        case 200...232:
            return "cloud.bolt"
        case 300...321:
            return "cloud.drizzle"
        case 500...531:
            return "cloud.rain"
        case 600...622:
            return "cloud.snow"
        case 700...781:
            return "cloud.fog"
        case 800:
            return "sun.max"
        case 801...804:
            return "cloud"
        default:
            return "sun.min"
        }
    }
}

extension Double{
    func round(to: Int) -> Double{
        let multiplier = pow(10, Double(to))
        var n = self
        n *= multiplier
        n.round()
        n /= multiplier
        return n
    }
}
