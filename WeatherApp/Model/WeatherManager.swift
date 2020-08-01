//
//  WeatherManager.swift
//  WeatherApp
//
//  Created by Metilli on 31.07.2020.
//  Copyright © 2020 Mac. All rights reserved.
//

import Foundation

protocol WeatherManagerDelegate {
    func didUpdateWeather(_ weatherManager: WeatherManager, weatherModel: WeatherModel)
    func didErrorOnUpdate(_ weatherManager: WeatherManager, error: String)
}

struct WeatherManager{
    
    let weatherUrl = "https://api.openweathermap.org/data/2.5/weather?units=metric&appid=910d72c79dc95d9bb1bd553d230e6ffa"
    
    var delegate: WeatherManagerDelegate?
    
    func getWeatherInfo(cityName: String){
        let url = weatherUrl + "&q=" + cityName;
        performRequest(with: url, cityName: cityName)
    }
    
    func performRequest(with urlString: String, cityName: String){
        if let url = URL(string: urlString){
            let session = URLSession(configuration: .default)
            
            let task = session.dataTask(with: url) { (data, response, error) in
                if error != nil {
                    self.delegate?.didErrorOnUpdate(self, error: error!.localizedDescription)
                    return
                }
                if let safeData = data{
                    if let weather = self.parseJSON(safeData)
                    {
                        self.delegate?.didUpdateWeather(self, weatherModel: weather)
                    }else {
                        self.delegate?.didErrorOnUpdate(self, error: "This city name can not be found.")
                    }
                }
            }
            task.resume()
        }
    }
    
    func parseJSON(_ data: Data) -> WeatherModel?{
        let decoder = JSONDecoder()
        do{
            let decodedData = try decoder.decode(WeatherData.self, from: data)
            let conditionID = decodedData.weather[0].id
            let cityName = decodedData.name
            let temperature = decodedData.main.temp
            let humiditiy = decodedData.main.humidity
            let description = decodedData.weather[0].description
            let weatherModel = WeatherModel(conditionID: conditionID, cityName: cityName, temperature: temperature, humidity: humiditiy, weatherDescription: description)
            
            return weatherModel
        } catch {
            print(error)
        }
        return nil
    }
}
