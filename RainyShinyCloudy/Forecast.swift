//
//  AppDelegate.swift
//  RainyShinyCloudy
//
//  Created by Ali ZUberi
//  Copyright © 2017 ALi Zuberi. All rights reserved.
//


import UIKit
import Alamofire

class Forecast {
    
    var _date: String!
    var _weatherType: String!
    var _highTemp: String!
    var _lowTemp: String!
    var _timeStamp: String!
    var _windSpeed: Double!
    var _humidity: Int!
    
    var date: String {
        if _date == nil {
            _date = ""
        }
        return _date
    }
    
    var weatherType: String {
        if _weatherType == nil {
            _weatherType = ""
        }
        return _weatherType
    }
    
    var highTemp: String {
        if _highTemp == nil {
            _highTemp = ""
        }
        return _highTemp
    }
    
    var lowTemp: String {
        if _lowTemp == nil {
            _lowTemp = ""
        }
        return _lowTemp
    }
    
    var timeStamp: String {
        if _timeStamp == nil {
            _timeStamp = ""
        }
        return _timeStamp
    }
    
    var windSpeed: Double {
        if _windSpeed == nil {
            _windSpeed = 0.0
        }
        return _windSpeed
    }
    
    var humidity: Int {
        if _humidity == nil {
            _humidity = 0
        }
        return _humidity
    }
    
    
    init(weatherDict: Dictionary<String, AnyObject>) {
        if let temp = weatherDict["main"] as? Dictionary<String, AnyObject> {
            if let min = temp["temp_min"] as? Double {
                let kelvinToFarenheitPreDivision = (min) * (9/5) - 459.97
                let kelvinToFarenheit = Double(round(10 * kelvinToFarenheitPreDivision / 11))
                
                if convertTempToC == true {
                    self._lowTemp = "\(FtoC(fahrenheit: kelvinToFarenheit))"
                }
                    
                else {
                    self._lowTemp = "\(kelvinToFarenheit)"
                    
                }
                
            }
            if let max = temp["temp_max"] as? Double {
                let kelvinToFarenheitPreDivision = (max) * (9/5) - 459.97
                let kelvinToFarenheit = Double(round(10 * kelvinToFarenheitPreDivision / 11))
                if convertTempToC == true {
                    self._highTemp = "\(FtoC(fahrenheit: kelvinToFarenheit))"
                }
                
                else {
                    self._highTemp = "\(kelvinToFarenheit)"

                }
                
            }
            
            if let humidityLvl = temp["humidity"] as? Int {
                self._humidity = humidityLvl
            }
            
        }
        
        if let wind = weatherDict["wind"] as? Dictionary<String, AnyObject> {
            if let windSpeedMPH = wind["speed"] as? Double {
                let mpsToMPH = (windSpeedMPH * 2.2369)
                _windSpeed = Double(round(mpsToMPH))
            }
        }
        
        if let weather = weatherDict["weather"] as? [Dictionary<String, AnyObject>] {
        
            if let main = weather[0]["main"] as? String {
                self._weatherType = main
                }
        
            }
        
        if let timeStamp = weatherDict["dt_txt"] as? String {
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
            let date = dateFormatter.date(from: timeStamp)
            dateFormatter.dateFormat = "h a"
            self._timeStamp = dateFormatter.string(from: date!)
        }

        
        if let date = weatherDict["dt"] as? Double {
            let unixConvertedDate = Date(timeIntervalSince1970: date)
            let dateFormatter = DateFormatter()
            dateFormatter.dateStyle = .full
            dateFormatter.dateFormat = "EEEE"
            dateFormatter.timeStyle = .none
            self._date = unixConvertedDate.dayOfTheWeek()
        }
        
    
    }
}


extension Date {
    func dayOfTheWeek() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "EEEE"
        return dateFormatter.string(from: self)
    }
}
