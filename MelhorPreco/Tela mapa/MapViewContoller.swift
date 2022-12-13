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
    
    // gerenciador de localização local
    var locationManager: LocationManager?
    
    // mapa
    lazy var map: MKMapView = {
        map = MKMapView()
        map.translatesAutoresizingMaskIntoConstraints = false
        map.showsUserLocation = true
        return map
    }()
   

    override func viewDidLoad() {
        super.viewDidLoad()
        // inicia o gerenciador de localização local
        locationManager = LocationManager(mainView: self)
        
        // verifica se é possível obter a localização
        locationManager!.checkIfLocationServicesIsEnabled()
        
        // caso esteja disponivel é utilizada
        if let location = locationManager!.userLocation {
            map.region = MKCoordinateRegion(center: location, span: MKCoordinateSpan(latitudeDelta: 0.1, longitudeDelta: 0.1))
        }
        // caso não esteja disponível é mostrado o ponto (0,0)
        else{
            map.region = MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: 0, longitude: 0), span: MKCoordinateSpan(latitudeDelta: 0.1, longitudeDelta: 0.1))
        }
        view.addSubview(map)
        
        // configura as contraints do mapa
        configMap()
        // deine a cor de fundo da view como branco
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
    
    // função chamda sempre que é alterada a autorização
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
    // a view que ele se encontra para ser a delegate
    var mainView: CLLocationManagerDelegate?
    // o gerenciador em si
    var manager: CLLocationManager?
    // coordenadas da localização do usuário
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
    
    // checa localização e gerencia todos os possíveis casos
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

