//
//  AppDelegate.swift
//  RainyShinyCloudy
//
//  Created by Ali ZUberi
//  Copyright © 2017 ALi Zuberi. All rights reserved.
//

import UIKit

class ForecastCell: UITableViewCell {
    @IBOutlet weak var weatherIcon: UIImageView!

    @IBOutlet weak var highTemp: UILabel!
    
    @IBOutlet weak var weatherType: UILabel!
    
    @IBOutlet weak var day: UILabel!
    
    @IBOutlet weak var lowTemp: UILabel!
    
    
    
    var forecast: Forecast!
    
    func updateTableForecast(forecast: Forecast)  {
        
        day.text = forecast.date
        
        weatherIcon.image = UIImage(named: forecast.weatherType)
        weatherType.text = forecast.weatherType
        
        
        if convertTempToC == true {
            highTemp.text = "\((round(100*FtoC(fahrenheit: Double(forecast.highTemp)!)/100)))°C"
            lowTemp.text = "\((round(100*FtoC(fahrenheit: Double(forecast.lowTemp)!)/100)))°C"
    }
        else {
            highTemp.text = "\(forecast.highTemp)°F"
            lowTemp.text = "\(forecast.lowTemp)°F"
        }
        
        
        
        
        }
   
        
}


