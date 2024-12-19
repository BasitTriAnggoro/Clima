//
//  ViewController.swift
//  Clima
//
//  Created by Angela Yu on 01/09/2019.
//  Copyright © 2019 App Brewery. All rights reserved.
//

import UIKit

class WeatherViewController: UIViewController, UITextFieldDelegate, WeatherManagerDelegate{
    @IBOutlet weak var conditionImageView: UIImageView!
    @IBOutlet weak var temperatureLabel: UILabel!
    @IBOutlet weak var cityLabel: UILabel!
    @IBOutlet weak var searchBar: UITextField!
    @IBOutlet weak var searchIconButton: UIButton!
    
    // deklarasi variabel weatherManager dan memberikan nilainya berupa WeatherManager()
    var weatherManager = WeatherManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        searchBar.delegate = self
        
        // menginisiasi nilai delegate (yg di WeatherManager) ke dalam class WeatherViewController
        weatherManager.delegate = self
    }
    
    // 72576e0ea0519b91bc3fc427d5e90366
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if let cityName = searchBar.text{
            weatherManager.fetchWeather(with: cityName)
        }
        searchBar.text = ""
        searchBar.endEditing(true)
        return true
    }
    
    @IBAction func searchIconPressed(_ sender: Any) {
        if let cityName = searchBar.text{
            weatherManager.fetchWeather(with: cityName)
        }
        searchBar.text = ""
        searchBar.endEditing(true)
    }
    
    func didUpdateWeather(_ weather: WeatherModel) {
        print(weather)
    }
    
    func didFailWithError(_ error: Error) {
        print(error)
    }
}

