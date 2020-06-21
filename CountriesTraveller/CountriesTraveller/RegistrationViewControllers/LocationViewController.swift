//
//  LocationViewController.swift
//  CountriesTraveller
//
//  Created by Steew on 15.06.2020.
//  Copyright © 2020 Steew. All rights reserved.
//

import UIKit
import MapKit
import CoreLocation

class LocationViewController: UIViewController, CLLocationManagerDelegate {
    @IBOutlet weak var locationLabel: UILabel!
    @IBOutlet weak var mapView: MKMapView!
    @IBOutlet weak var nextButton: UIButton!
    
    var user = UserProfile()
    let locationManager = CLLocationManager()
    var location2: CLLocationCoordinate2D?

    override func viewDidLoad() {
        super.viewDidLoad()
        locationManager.delegate = self
        prepareView()
        getUserLocation()
    }

    func prepareView() {
        view.backgroundColor = UIColor(patternImage: UIImage(named: "background")!)
        locationLabel.backgroundColor = .systemFill
        locationLabel.numberOfLines = 0
        locationLabel.textAlignment = .center
        locationLabel.font = .systemFont(ofSize: 26)
        locationLabel.frame = CGRect(x: 20, y: view.bounds.height / 2 - 50, width: view.bounds.width - 40, height: 100)
    }
    
    func getUserLocation() {
        locationManager.requestAlwaysAuthorization()
        locationManager.startUpdatingLocation()
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let location = locations.last {
            locationLabel.text = "Lat : \(location.coordinate.latitude) \nLng : \(location.coordinate.longitude)"
            location2 = CLLocationCoordinate2D(latitude: location.coordinate.latitude,
            longitude: location.coordinate.longitude)
            let span = MKCoordinateSpan(latitudeDelta: 0.05, longitudeDelta: 0.05)
            let region = MKCoordinateRegion(center: location2!, span: span)
            mapView.setRegion(region, animated: true)
        }
    }
    
    @IBAction func onTapNextButton(_ sender: Any) {
        if let vc = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "PhoneViewController") as? PhoneViewController{
            vc.user = user
            self.navigationController?.pushViewController(vc, animated: true)
        }
    }
    @IBAction func onTapBackButton(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    
}

