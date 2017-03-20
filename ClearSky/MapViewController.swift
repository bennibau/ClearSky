//
//  MapViewController.swift
//  ClearSky
//
//  Created by Benjamin Baumann on 03.03.17.
//  Copyright © 2017 Benjamin Baumann. All rights reserved.
//

import UIKit
import MapKit

class MapViewController: UIViewController {

    @IBOutlet weak var loadingIndicator: UIActivityIndicatorView!
    @IBOutlet weak var loadingView: UIVisualEffectView!
    @IBOutlet weak var map: MKMapView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadingView.isHidden = true
        loadingView.layer.cornerRadius = 10
        loadingView.clipsToBounds = true
        
        let longpressGestureRecognizer = UILongPressGestureRecognizer(target: self,action: #selector(self.longpress))
        map.addGestureRecognizer(longpressGestureRecognizer)
    }
    
    func longpress(gestureRecognizer: UIGestureRecognizer) {
        if gestureRecognizer.state == UIGestureRecognizerState.began {
            let touchPoint = gestureRecognizer.location(in: self.map)
            let coordinate = map.convert(touchPoint, toCoordinateFrom: self.map)
            print("coordinate: \(coordinate.latitude),\(coordinate.longitude)")
            loadingView.isHidden = false
            loadingIndicator.startAnimating()
            
            ForecastRequest .requestForecastForCoordinate(coordinate: coordinate, completion: { (forecastViewModels) in
                DispatchQueue.main.async {
                    let storyboard = UIStoryboard(name: "Main", bundle: nil)
                    let forecastViewController = storyboard.instantiateViewController(withIdentifier: "forecastViewController") as! ForecastViewController
                    forecastViewController.viewModels = forecastViewModels
                    
                    self.navigationController!.pushViewController(forecastViewController, animated: true)
                    self.loadingView.isHidden = true
                }
            }, failed: {
                DispatchQueue.main.async {
                    self.loadingView.isHidden = true
                    let alertView = UIAlertController(title: "Request failed", message: "Could not retrieve forecast!", preferredStyle: UIAlertControllerStyle.alert)
                    let alertAction = UIAlertAction(title: "Ok", style: UIAlertActionStyle.default, handler: { (action) in
                        alertView.dismiss(animated: true, completion: nil)
                    })
                    alertView.addAction(alertAction)
                    self.present(alertView, animated: true, completion: nil)
                }
            })
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.setNavigationBarHidden(true, animated: animated)
        super.viewWillAppear(animated)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        self.navigationController?.setNavigationBarHidden(false, animated: animated)
        super.viewWillDisappear(animated)
    }
    
}
