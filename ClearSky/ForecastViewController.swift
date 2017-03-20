//
//  ViewController.swift
//  ClearSky
//
//  Created by Benjamin Baumann on 03.03.17.
//  Copyright © 2017 Benjamin Baumann. All rights reserved.
//

import UIKit
import MapKit

class ForecastViewController: UIViewController,UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var tableView: UITableView!
    var viewModels : [ForecastViewModel]?
    
    convenience init(forecastViewModel: [ForecastViewModel]){
        self.init()
        viewModels = forecastViewModel
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModels!.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier:"weatherCell") as! WeatherTableViewCell
        cell.tempLabel.text = "\(viewModels![indexPath.row].temperatureMin)°/\(viewModels![indexPath.row].temperatureMax)°"
        cell.summaryLabel.text = viewModels?[indexPath.row].summary
        cell.dayLabel.text = viewModels?[indexPath.row].date
        let iconName = "\(viewModels![indexPath.row].icon).jpg"
        cell.icon.image = UIImage(named: iconName)
        cell.icon.contentMode = UIViewContentMode.scaleAspectFit
        return cell
    }
    
    


}

