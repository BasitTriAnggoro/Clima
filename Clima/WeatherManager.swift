//
//  WeatherManager.swift
//  Clima
//
//  Created by Basit Tri Anggoro on 03/12/24.
//  Copyright © 2024 App Brewery. All rights reserved.
//

import Foundation

protocol WeatherManagerDelegate{
    func didUpdateWeather(_ weather: WeatherModel)
    func didFailWithError(_ error: Error)
}

struct WeatherManager{
    let weatherURL = "https://api.openweathermap.org/data/2.5/weather?&appid=72576e0ea0519b91bc3fc427d5e90366&units=metric"
    
    // deklarasi variabel delegasi (delegate) untuk didelegasikan ke class lain yg berupa protocol bernama WeatherManagerDelegate
    var delegate: WeatherManagerDelegate?
    
    func fetchWeather(_ cityName: String){
        let urlString = "\(weatherURL)&q=\(cityName)"
        performRequest(with: urlString)
    }
    
    func fetchWeather(lon: String, lat: String){
        let urlString = "\(weatherURL)\("&lat=")\(lat)\("&lon=")\(lon)"
        performRequest(with: urlString)
    }
    
    func performRequest(with urlString: String){
        // STEP NETWORKING
        // 1. BIKIN URL
        if let url = URL(string: urlString){
            // 2. BIKIN SESSION
            let session = URLSession(configuration: .default)
            // 3. KASIH TASK
            let task = session.dataTask(with: url){(data,response,error) in
                if let error = error{
                    self.delegate?.didFailWithError(error)
                    print("weathermanager failed: \(error)")
                }
                
                if let safeData = data{
                    // data dari network/internet (berupa JSON) harus didecode dulu ke dalam bentuk struct swift (model)
                    if let weather = parseJSON(with: safeData){
                        // delegasi diinisiasi dengan mengambil data dari weather(data cuaca yg sudah didecode)
                        // parameter dari function didUpdateWeather (dari protocol WeatherManagerDelegate) sudah terisi dan sudah tersimpan ke dalam variabel delegate (di struct WeatherManager/struct ini)
                        delegate?.didUpdateWeather(weather)
                        print("weathermanager success: \(weather)")
                    }
                }
            }
            // 4. MULAI TUGAS
            task.resume()
        }
    }
    
    func parseJSON(with weatherData: Data)->WeatherModel?{
        let decoder = JSONDecoder()
        do {
            let decoded = try decoder.decode(WeatherData.self, from: weatherData)
            
            let id = decoded.weather[0].id
            let cityName = decoded.name
            let temperature = decoded.main.temp
            
            let weather = WeatherModel(id: id, cityName: cityName, temperature: temperature)
            return weather
        } catch {
            delegate?.didFailWithError(error)
            return nil
        }
    }
}
