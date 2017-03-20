//
//  ForecastRequest.swift
//  ClearSky
//
//  Created by Benjamin Baumann on 03.03.17.
//  Copyright © 2017 Benjamin Baumann. All rights reserved.
//

import UIKit
import MapKit

class ForecastRequest: NSObject {
    
    static func requestForecastForCoordinate(coordinate: CLLocationCoordinate2D,completion: @escaping ([ForecastViewModel]) -> Void,failed: @escaping () -> Void) {
        
        var request = URLRequest(url: URL(string: "https://api.darksky.net/forecast/62e78d90cc9013ec92ed3bc355d9ba20/\(coordinate.latitude),\(coordinate.longitude)?exclude=currently,flags")!)
        request.httpMethod = "GET"
        let session = URLSession.shared
        
        session.dataTask(with: request) {data, response, err in
            if(err != nil){
                print(err.debugDescription)
                failed()
            }else{
                do{
                    let json = try JSONSerialization.jsonObject(with: data!, options:.allowFragments) as! [String : AnyObject]
                    let forecast = Forecast(data: json);
                    var dailyForecasts = [ForecastViewModel]()
                    for dataPoint in forecast.daily!{
                        let forecastViewModel = ForecastViewModel(forecast: dataPoint)
                        dailyForecasts.append(forecastViewModel)
                    }
                    print("Forecast successfully downloaded")
                    completion(dailyForecasts)
                    
                }catch let error as NSError{
                    print("Could not parse response: \(error)")
                    failed()
                }
            }
        }.resume()
    }
    
}
