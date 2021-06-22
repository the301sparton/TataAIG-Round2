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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        GMSServices.provideAPIKey(Util.gmapAPIKey)
        let camera = GMSCameraPosition.camera(withLatitude: 19.0760, longitude: 72.8777, zoom: 8)
        mapView = GMSMapView.map(withFrame: self.view.frame, camera: camera)
        mapHolder.addSubview(mapView!)
        
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
