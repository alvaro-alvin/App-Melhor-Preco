//
//  MapViewContoller.swift
//  MelhorPreco
//
//  Created by user on 30/11/22.
//

import Foundation
import UIKit
import MapKit

class MapViewController: UIViewController, CLLocationManagerDelegate {
    
    var locationManager: LocationManager?
    
    lazy var map: MKMapView = {
        map = MKMapView()
        map.translatesAutoresizingMaskIntoConstraints = false
        map.showsUserLocation = true
        return map
    }()
   

    override func viewDidLoad() {
        super.viewDidLoad()
        locationManager = LocationManager(mainView: self)
        
        locationManager!.checkIfLocationServicesIsEnabled()
        
        if let location = locationManager!.userLocation {
            map.region = MKCoordinateRegion(center: location, span: MKCoordinateSpan(latitudeDelta: 0.1, longitudeDelta: 0.1))
        } else{
            map.region = MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: 0, longitude: 0), span: MKCoordinateSpan(latitudeDelta: 0.1, longitudeDelta: 0.1))
        }
        view.addSubview(map)
        
        
        configMap()
        view.backgroundColor = .white
            }
    
   
    private func configMap() {
        NSLayoutConstraint.activate([
            map.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            map.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10),
            map.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -10),
            map.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -10)
        ])
    }
    
    // fubnção chamda sempre que é alterada a autorização
    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        locationManager!.checkLocationAuthorization()
        if let location = locationManager!.userLocation {
            map.region = MKCoordinateRegion(center: location, span: MKCoordinateSpan(latitudeDelta: 0.1, longitudeDelta: 0.1))
        } else{
            map.region = MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: 0, longitude: 0), span: MKCoordinateSpan(latitudeDelta: 0.1, longitudeDelta: 0.1))
        }
        
    }
}


class LocationManager{
    
    var mainView: CLLocationManagerDelegate?
    var manager: CLLocationManager?
    var userLocation: CLLocationCoordinate2D?
    
    init(mainView: CLLocationManagerDelegate?){
        self.mainView = mainView
    }
    
    func checkIfLocationServicesIsEnabled(){
        if CLLocationManager.locationServicesEnabled(){
            manager = CLLocationManager()
            manager!.delegate = mainView
        }
        else{
            print("alert to indicate user what happened")
        }
    }
    
    func checkLocationAuthorization(){
        guard let manager = manager else {return}
        
        switch manager.authorizationStatus {
            
        case .notDetermined:
            manager.requestWhenInUseAuthorization()
        case .restricted:
            print("yor location is restricted likly parention control")
        case .denied:
            print("cara, ce desativou pra nos, vai ativar")
        case .authorizedAlways, .authorizedWhenInUse:
            userLocation = manager.location!.coordinate
            print("localização obtida")
        @unknown default:
            break
        }
    }
}

