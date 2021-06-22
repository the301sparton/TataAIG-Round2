//
//  MapViewController.swift
//  TataAIG
//
//  Created by Chaitanya Deshpande on 22/06/21.
//

import UIKit
import GoogleMaps
class MapViewController: UIViewController {
    
    @IBOutlet weak var mapHolder: UIView!
    
    @IBOutlet weak var bottomDetailView: UIView!
    var vehicleArray : VehicleArray? = nil
    var selectedVehicle : Vehicle? = nil
    var mapView : GMSMapView? = nil
    let geocoder = GMSGeocoder()

    override func viewDidLoad() {
        super.viewDidLoad()
        let camera = GMSCameraPosition.camera(withLatitude: 19.0760, longitude: 72.8777, zoom: 8)
        mapView = GMSMapView.map(withFrame: self.view.frame, camera: camera)
        mapHolder.addSubview(mapView!)
        mapView?.delegate = self
        
        setAllMarkers()
        if let selectedVehicle = selectedVehicle {
            zoomToCoordinates(coordinate: selectedVehicle.coordinate!)
        }
        mapHolder.bringSubviewToFront(bottomDetailView)
        bottomDetailView.layer.cornerRadius = 20
        bottomDetailView.clipsToBounds = true
    }
    
    func setAllMarkers() {
        if let vehicleArray = vehicleArray {
            for vehicle in vehicleArray.poiList! {
                let marker = GMSMarker()
                marker.position = CLLocationCoordinate2D(latitude: (vehicle.coordinate?.latitude)!, longitude: (vehicle.coordinate?.longitude)!)
                marker.title = "\(vehicle.id ?? 0)"
                marker.snippet = vehicle.fleetType
                marker.map = mapView
            }
        }
    }
    
    func zoomToCoordinates(coordinate : VehicleCoordinate) {
        let camera = GMSCameraPosition.camera(withLatitude: coordinate.latitude ?? 0, longitude: coordinate.longitude ?? 0, zoom: 15)
        mapView?.animate(to: camera)
    }
    
}

extension MapViewController : GMSMapViewDelegate {
    func mapView(_ mapView: GMSMapView, idleAt cameraPosition: GMSCameraPosition) {
        geocoder.reverseGeocodeCoordinate(cameraPosition.target) { (response, error) in
          guard error == nil else {
            return
          }

          if let result = response?.firstResult() {
            let mapCenter = cameraPosition.target
            print(result)
            print(mapCenter)
          }
        }
      }
}
