//
//  MapVC.swift
//  Task1(SignUp_SignIn_Profile)
//
//  Created by IDE Academy on 6/1/20.
//  Copyright © 2020 Mostafa Saleh. All rights reserved.
//
import UIKit
import MapKit
import CoreLocation
protocol sendLocationToSignUpPage{
    func sendData(address:String)
}
class MapVC: UIViewController {
    
    @IBOutlet weak var addressLable: UILabel!
    @IBOutlet weak var mapViewer: MKMapView!
    let locationManger = CLLocationManager()
    var perivousLocation: CLLocation?
    var regionInMeters: Double = 10000
    var delegate:sendLocationToSignUpPage?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.hidesBackButton = true
        self.navigationItem.title = "Map View"
        checkLocationServices()
        // Do any additional setup after loading the view.
    }
    func setUpLocationManger() {
        locationManger.delegate = self
        locationManger.desiredAccuracy = kCLLocationAccuracyBest
    }
    func checkLocationServices() {
        if CLLocationManager.locationServicesEnabled() {
            // set up our location manger
            setUpLocationManger()
            checkLocationAuthorization()
        }else{
            // show alert to enable location manger
        }
    }
    func centerViewOnUserLocation() {
        if let location = locationManger.location?.coordinate {
            let region = MKCoordinateRegion.init(center: location, latitudinalMeters: regionInMeters, longitudinalMeters: regionInMeters)
            mapViewer.setRegion(region, animated: true)
        }
    }
    func getCenterLocation(mapView:MKMapView) -> CLLocation {
        let latitude = mapView.centerCoordinate.latitude
        let longitude = mapView.centerCoordinate.longitude
        return CLLocation(latitude: latitude, longitude: longitude)
    }
    func checkLocationAuthorization() {
        switch CLLocationManager.authorizationStatus() {
        case .authorizedWhenInUse:
            // do map stuff
            startTrackigUserLocation()
        case .denied:
            // show alert to instructing them how to enable permissions
            break
        case .notDetermined:
            locationManger.requestWhenInUseAuthorization()
            break
        case .restricted:
            // show alarm to let them know why they are restricted
            break
        case .authorizedAlways:
            break
    }
  }
    func startTrackigUserLocation() {
        mapViewer.showsUserLocation = true
        centerViewOnUserLocation()
        locationManger.startUpdatingLocation()
        perivousLocation = getCenterLocation(mapView: mapViewer)
    }
    @IBAction func submitLocationButtonPressed(_ sender: UIButton) {
            delegate?.sendData(address: self.addressLable.text ?? "N/A")
            self.dismiss(animated: true, completion: nil)
        }
}

extension MapVC:CLLocationManagerDelegate {
//    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
//        //   This function is to update the user location beased on user's moves on the map
//
//        guard let location = locations.last else {return}
//        let center = CLLocationCoordinate2D(latitude: location.coordinate.latitude, longitude: location.coordinate.longitude)
//        let region = MKCoordinateRegion.init(center: center, latitudinalMeters: regionInMeters, longitudinalMeters: regionInMeters)
//        mapViewer.setRegion(region, animated: true)
//
//    }

    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        //  This function is to show the permessions that is the app will use use's mobile location
        checkLocationAuthorization()
    }
}
extension MapVC:MKMapViewDelegate {
    func mapView(_ mapView: MKMapView, regionDidChangeAnimated animated: Bool) {
        let center = getCenterLocation(mapView: mapViewer)
        let geocoder = CLGeocoder()
        guard perivousLocation != nil else {return}
        guard center.distance(from: perivousLocation! ) > 50 else { return}
        perivousLocation = center
        geocoder.reverseGeocodeLocation(center) { [weak self] (plascemark, error) in
            guard let self = self else {return}
            if let _ = error {
                // do alert to inform the user
                return
            }
            guard let placemark = plascemark?.first else {
                // do alert to inform the user
                return
            }
            let streetNumber = placemark.subThoroughfare ?? ""
            let streetName = placemark.thoroughfare ?? ""
            DispatchQueue.main.async {
                self.addressLable.text = "\(streetNumber) \(streetName)"
               // UserDefaults.standard.set(self.addressLable.text, forKey: "Address")
            }
        }
    }
}
