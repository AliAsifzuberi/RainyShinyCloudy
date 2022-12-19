//
//  AppDelegate.swift
//  RainyShinyCloudy
//
//  Created by Ali ZUberi
//  Copyright © 2017 ALi Zuberi. All rights reserved.
//

import UIKit
import Alamofire
import CoreLocation

class WeatherVC: UIViewController, UITableViewDataSource, UITableViewDelegate, CLLocationManagerDelegate {
    
    @IBOutlet weak var dateLabel: UILabel!
    
    @IBOutlet weak var currentTempLabel: UILabel!

    @IBOutlet weak var currentWeatherType: UILabel!
    @IBOutlet weak var locationLabel: UILabel!
    @IBOutlet weak var currentWeatherImage: UIImageView!
    @IBOutlet weak var tempTableView: UITableView!
    
    @IBOutlet weak var tempSwitch: UISwitch!
    @IBOutlet weak var mainView: UIView!
    let locationManager = CLLocationManager()
    var currentLocation: CLLocation!
    
    var currentWeather = CurrentWeather()
    var forecast: Forecast!
    var forecasts = [Forecast]()
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tempTableView.delegate = self
        tempTableView.dataSource = self
        
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.requestWhenInUseAuthorization()
        locationManager.startMonitoringSignificantLocationChanges()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        locationAuthStatus()
    }
    
    func locationAuthStatus() {
        if CLLocationManager.authorizationStatus() == .authorizedWhenInUse {
            currentLocation = locationManager.location
            Location.sharedInstance.lat = currentLocation.coordinate.latitude
            Location.sharedInstance.lon = currentLocation.coordinate.longitude
            currentWeather.downloadWeatherDetails {
                self.downloadForecast {
                    self.updateMainUI()
                }
                
            }
        }
    
        else {
            locationManager.requestWhenInUseAuthorization()
            locationAuthStatus()
        }
    }
    
    
    func downloadForecast(completed: @escaping DownloadComplete) {
        let forecastURL = URL(string: FORECAST_URL)
        Alamofire.request(forecastURL!).responseJSON { response in
            let result = response.result

            
            if let dict = result.value as? Dictionary<String, AnyObject> {
                if let list = dict["list"] as? [Dictionary<String, AnyObject>] {
                    
                    for obj in list {
                        let forecast = Forecast(weatherDict: obj)
                        self.forecasts.append(forecast)
                    }
                    self.tempTableView.reloadData()
            
                }
            }
            completed()
        }
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return forecasts.count
    }
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tempTableView.dequeueReusableCell(withIdentifier: "WeatherCell", for: indexPath) as? ForecastCell {
            let forecast = forecasts[indexPath.row]
            cell.updateTableForecast(forecast: forecast)
            
            return cell
            
        }
        
        else {
            return ForecastCell()
        }
        
    }

    func updateMainUI() {
        dateLabel.text = currentWeather.date
        currentTempLabel.text = "\(currentWeather.currentTemp)°F"
        currentWeatherType.text = currentWeather.weatherType
        locationLabel.text = currentWeather.cityName
        currentWeatherImage.image = UIImage(named: currentWeather.weatherType)
        
    }
    @IBAction func updateWeather(_ sender: Any) {
        currentWeather.downloadWeatherDetails {
            self.updateMainUI()
            self.tempTableView.reloadData()
            }
       
        }

    @IBAction func switchTempType(sender: UISwitch) {
        if sender.isOn == true  {
            currentTempLabel.text = "\(currentWeather.currentTemp)°F"
            tempTableView.reloadData()
            convertTempToC = false
            
        }
        
        else {
            currentTempLabel.text = "\(round(FtoC(fahrenheit: currentWeather.currentTemp)))°C"
            tempTableView.reloadData()
            convertTempToC = true

           
        }
        
    }
  

}

