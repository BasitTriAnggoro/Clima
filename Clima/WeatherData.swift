//
//  WeatherData.swift
//  Clima
//
//  Created by Basit Tri Anggoro on 04/12/24.
//  Copyright © 2024 App Brewery. All rights reserved.
//

//  BERISI DATA YANG

import Foundation

struct WeatherData: Codable {
    let name: String
    let main: Main
    let weather: [Weather]
}

struct Main: Codable{
    let temp: Float
}

struct Weather: Codable{
    let main: String
    let id: Int
}
