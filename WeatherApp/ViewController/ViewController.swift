//
//  ViewController.swift
//  WeatherApp
//
//  Created by Metilli on 31.07.2020.
//  Copyright © 2020 Mac. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITextFieldDelegate, WeatherManagerDelegate{
    
    @IBOutlet weak var searchTextField: UITextField!
    @IBOutlet weak var cityNameLabel: UILabel!
    @IBOutlet weak var temperatureLabel: UILabel!
    @IBOutlet weak var humidityLabel: UILabel!
    @IBOutlet weak var weatherImage: UIImageView!
    @IBOutlet weak var weatherDescriptionLabel: UILabel!
    
    var weatherManager = WeatherManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        weatherManager.delegate = self
        searchTextField.delegate = self
    }
    
    @IBAction func searchPressed(_ sender: UIButton) {
        if let city = searchTextField.text{
            weatherManager.getWeatherInfo(cityName: city)
        }
        searchTextField.endEditing(true)
        searchTextField.text = ""
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if let city = textField.text{
            weatherManager.getWeatherInfo(cityName: city)
        }
        return true
    }
    
    func textFieldShouldEndEditing(_ textField: UITextField) -> Bool {
        textField.endEditing(true)
        textField.text = ""
        return true
    }
    
    func didUpdateWeather(_ weatherManager: WeatherManager, weatherModel: WeatherModel){
        DispatchQueue.main.async {
            self.cityNameLabel.text = weatherModel.cityName
            self.temperatureLabel.text = weatherModel.temperatureString
            self.humidityLabel.text = weatherModel.humidityString
            self.weatherImage.image = UIImage(systemName: weatherModel.weatherImage)
            self.weatherDescriptionLabel.text = weatherModel.weatherDescription
        }
    }
    
    func didErrorOnUpdate(_ weatherManager: WeatherManager, error: String) {
        DispatchQueue.main.async {
            let alert = UIAlertController(title: "Error!", message: error, preferredStyle: .alert)
            
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            
            self.present(alert, animated: true)
        }
    }
}

