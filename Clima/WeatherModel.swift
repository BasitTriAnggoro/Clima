//
//  WeatherModel.swift
//  Clima
//
//  Created by Basit Tri Anggoro on 05/12/24.
//  Copyright © 2024 App Brewery. All rights reserved.
//

import Foundation

struct WeatherModel {
    let id:Int
    let cityName:String
    let temperature:Float
    
    // computed properties
    var temperatureString: String{
        return String(format: "%.0f", temperature)
    }
    
    // computed properties
    var condition: String{
        switch id {
        case 200...232:
            return "cloud.bolt"
        case 300...321:
            return "cloud.drizzle"
        case 500...531:
            return "cloud.rain"
        case 600...622:
            return "cloud.snow"
        case 701...781:
            return "cloud.fog"
        case 800:
            return "sun.max"
        case 801...804:
            return "cloud.bolt"
        default:
            return "cloud"
        }
    }
}
