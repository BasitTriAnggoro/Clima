//
//  ViewController.swift
//  Clima
//
//  Created by Angela Yu on 01/09/2019.
//  Copyright © 2019 App Brewery. All rights reserved.
//

import UIKit
import CoreLocation

class WeatherViewController: UIViewController{
    @IBOutlet weak var conditionImageView: UIImageView!
    @IBOutlet weak var temperatureLabel: UILabel!
    @IBOutlet weak var cityLabel: UILabel!
    @IBOutlet weak var searchBar: UITextField!
    @IBOutlet weak var searchIconButton: UIButton!
    
    // deklarasi variabel weatherManager dan memberikan nilainya berupa WeatherManager()
    var weatherManager = WeatherManager()
    var locationManager = CLLocationManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        searchBar.delegate = self
        
        // menginisiasi nilai delegate (yg di WeatherManager) ke dalam class WeatherViewController
        weatherManager.delegate = self
        
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        
        locationManager.requestWhenInUseAuthorization()
        locationManager.requestLocation()
    }
    // 72576e0ea0519b91bc3fc427d5e90366
}

//MARK: - LOCATION MANAGER DELEGATE
extension WeatherViewController: CLLocationManagerDelegate{
    @IBAction func navigationDidPressed(_ sender: Any) {
        locationManager.requestLocation()
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        print("updated location")
//        print(locations)
        if let location = locations.last{
            locationManager.stopUpdatingLocation()
            let lat = String(location.coordinate.latitude)
            let lon = String(location.coordinate.longitude)
            weatherManager.fetchWeather(lon: lon, lat: lat)
            print("Updated Location: \(location.coordinate.latitude), \(location.coordinate.longitude)")
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: any Error) {
        print(error)
    }
}

//MARK: - TEXTFIELD DELEGATE
extension WeatherViewController: UITextFieldDelegate{
    func emptyString(){
        if let cityName = searchBar.text{
            weatherManager.fetchWeather(cityName)
        }
        searchBar.text = ""
        searchBar.endEditing(true)
    }
    
    @IBAction func searchIconPressed(_ sender: Any) {
        emptyString()
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        emptyString()
        return true
    }
}

//MARK: - WEATHER MANAGER DELEGATE
extension WeatherViewController: WeatherManagerDelegate{
    func didUpdateWeather(_ weather: WeatherModel) {
        print(weather)
        DispatchQueue.main.async {
            self.conditionImageView.image = UIImage(systemName: weather.condition)
            self.cityLabel.text = weather.cityName
            self.temperatureLabel.text = weather.temperatureString
        }
    }
    
    func didFailWithError(_ error: Error) {
        print(error)
    }
}
