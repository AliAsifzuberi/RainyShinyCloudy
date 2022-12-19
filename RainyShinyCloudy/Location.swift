//
//  AppDelegate.swift
//  RainyShinyCloudy
//
//  Created by Ali ZUberi
//  Copyright © 2017 ALi Zuberi. All rights reserved.
//


import CoreLocation

class Location {
    static var sharedInstance = Location()
    private init() {}
    
    var lat: Double!
    var lon: Double!
}
