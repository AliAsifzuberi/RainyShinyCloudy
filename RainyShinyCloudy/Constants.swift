//
//  AppDelegate.swift
//  RainyShinyCloudy
//
//  Created by Ali ZUberi
//  Copyright © 2017 ALi Zuberi. All rights reserved.
//

import Foundation


let BASE_URL = "http://api.openweathermap.org/data/2.5/weather?"
let LATIDUDE = "lat="
let LONGITUDE = "&lon="
let APP_ID = "&appid="
let API_KEY = "acc9a28f2257f22393c25b03e0494151"
var convertTempToC = false

typealias DownloadComplete = () -> ()

let CURRENT_WEATHER_URL = "http://api.openweathermap.org/data/2.5/weather?lat=\(Location.sharedInstance.lat!)&lon=\(Location.sharedInstance.lon!)&appid=acc9a28f2257f22393c25b03e0494151"

let FORECAST_URL = "http://api.openweathermap.org/data/2.5/forecast?lat=\(Location.sharedInstance.lat!)&lon=\(Location.sharedInstance.lon!)&appid=acc9a28f2257f22393c25b03e0494151"

func FtoC(fahrenheit: Double) -> Double {
    let FtoC = (fahrenheit - 32) * (5/9)
    return FtoC
    
}
