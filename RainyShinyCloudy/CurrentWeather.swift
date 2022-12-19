//
//  AppDelegate.swift
//  RainyShinyCloudy
//
//  Created by Ali ZUberi
//  Copyright © 2017 ALi Zuberi. All rights reserved.
//


import UIKit
import Alamofire

class CurrentWeather {
    var _cityname: String!
    var _date: String!
    var _currentTemp: Double!
    var _weatherType:String!
    
    var date: String {
        if _date == nil {
            _date = ""
        }
        
        let dateFormatter = DateFormatter()
        
        dateFormatter.dateStyle = .long
        dateFormatter.timeStyle = .none
        let currentDate = dateFormatter.string(from: Date())
        self._date = "Today, \(currentDate)"
        return _date
    }
    
    var cityName: String {
        if _cityname == nil {
            _cityname = ""
        }
        
        return _cityname
    }
    
    var weatherType: String {
        if _weatherType == nil {
            _weatherType = ""
        }
        
        return _weatherType
    }
    
    var currentTemp: Double {
        if _currentTemp == nil {
            _currentTemp = 0.0
        }
        
        return _currentTemp
    }
    
    func downloadWeatherDetails( completed: @escaping DownloadComplete) {
        Alamofire.request(CURRENT_WEATHER_URL).responseJSON { response in
           let result = response.result
            
            if let dict = result.value as? Dictionary<String, AnyObject> {
                
                if let name = dict["name"] as? String {
                    self._cityname = name.capitalized
                }
                if let weather = dict["weather"] as? [Dictionary<String, AnyObject>] {
                    if let main = weather[0]["main"] as? String {
                        self._weatherType = main.capitalized
                    }
                }
                
                if let temp = dict["main"] as? Dictionary<String, AnyObject> {
                    if let currentTemperature = temp["temp"] as? Double {
                       
                        let kelvinToFarenheitPreDivision = (currentTemperature) * (9/5) - 459.97
                        let kelvinToFarenheit = Double(round(10 * kelvinToFarenheitPreDivision / 11))
                        self._currentTemp = kelvinToFarenheit
                        
                    }
                    
                    
                }
            }
            completed()

        }
        
    }
    
}

