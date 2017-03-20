//
//  ForecastViewModel.swift
//  ClearSky
//
//  Created by Benjamin Baumann on 03.03.17.
//  Copyright © 2017 Benjamin Baumann. All rights reserved.
//

import UIKit

class ForecastViewModel: NSObject {
    
    var forecast : ForecastDataPoint
    
    var temperatureMax : Int = -1
    var temperatureMin : Int = -1
    var summary : String = ""
    var icon : String = ""
    var date : String = ""
    
    init(forecast: ForecastDataPoint) {
        self.forecast = forecast
        super.init()
        
        if let tempMax = forecast.temperatureMax {
            temperatureMax = self.fahrenheitToCelsius(temp: tempMax)
        }
        
        if let tempMin = forecast.temperatureMin {
            temperatureMin = self.fahrenheitToCelsius(temp: tempMin)
        }
        
        if let sum = forecast.summary {
            summary = sum
        }
        
        if let icon = forecast.icon {
            self.icon = icon
        }
        
        if let date = forecast.time {
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "dd-MM-yyyy"
            self.date = dateFormatter.string(from: date)
        }
    }
    
    func fahrenheitToCelsius(temp: Double) -> Int {
        //(°F − 32) / 1,8
        return Int(round((temp-32)/1.8))
    }
}
