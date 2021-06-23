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
    
    @IBOutlet weak var mapCenterLabel: UILabel!
    
    @IBOutlet weak var mapCenterCoordinateLabel: UILabel!
    
    @IBOutlet weak var loadingState: UILabel!
    
    var selectedVehicle : Vehicle? = nil
    var mapView : GMSMapView? = nil
    let geocoder = GMSGeocoder()
    var vehicleViewModal = VehicleViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        doUIConfig()
        setAllMarkers()
        mapView?.delegate = self
    }
    
    func doUIConfig() {
        toggleVisiblityForLoading(isLoading: true)
        vehicleViewModal.viewController = self
        
        let camera = GMSCameraPosition.camera(withLatitude: 19.0760, longitude: 72.8777, zoom: 8)
        mapView = GMSMapView.map(withFrame: self.view.frame, camera: camera)
        mapHolder.addSubview(mapView!)
        
        if let selectedVehicle = selectedVehicle {
            zoomToCoordinates(coordinate: selectedVehicle.coordinate!)
        }
        mapHolder.bringSubviewToFront(bottomDetailView)
        bottomDetailView.layer.cornerRadius = 20
        bottomDetailView.clipsToBounds = true
    }
    
    func setAllMarkers() {
        if let vehicelList = vehicleViewModal.vehicalArray?.poiList {
            for vehicle in vehicelList {
                let position = CLLocationCoordinate2D(latitude: vehicle.coordinate?.latitude ?? 0, longitude: vehicle.coordinate?.longitude ?? 0)
                let marker = GMSMarker(position: position)
                marker.title = "Vehicel Id : \(String(describing: vehicle.id!))"
                if vehicle.fleetType == "POOLING" {
                    marker.icon = UIImage.init(named: "carpool")
                }
                else {
                    marker.icon = UIImage.init(named: "taxi")
                }
                marker.rotation = CLLocationDegrees(vehicle.heading!)
                marker.map = mapView
            }
        }
    }
    
    func zoomToCoordinates(coordinate : VehicleCoordinate) {
        let camera = GMSCameraPosition.camera(withLatitude: coordinate.latitude ?? 0, longitude: coordinate.longitude ?? 0, zoom: 15)
        mapView?.animate(to: camera)
    }
    
    func toggleVisiblityForLoading(isLoading : Bool) {
        if isLoading {
            self.loadingState.visibility = .visible
            self.mapCenterLabel.visibility = .gone
            self.mapCenterCoordinateLabel.visibility = .gone
            
        }
        else {
            
            self.loadingState.visibility = .gone
            self.mapCenterLabel.visibility = .visible
            self.mapCenterCoordinateLabel.visibility = .visible
        }
    }
    
}

extension MapViewController : GMSMapViewDelegate {
    func mapView(_ mapView: GMSMapView, idleAt cameraPosition: GMSCameraPosition) {
        geocoder.reverseGeocodeCoordinate(cameraPosition.target) { (response, error) in
          guard error == nil else {
            return
          }

          if let result = response?.firstResult() {
            let mapCenter : VehicleCoordinate = VehicleCoordinate(lat: cameraPosition.target.latitude, lon: cameraPosition.target.longitude)
            self.mapCenterLabel.text = "Map Center : " + (result.lines?[0])!
            self.mapCenterCoordinateLabel.text = "( lat : \(String(describing: mapCenter.latitude!)) lon :  \(String(describing: mapCenter.longitude!)) )"
            self.toggleVisiblityForLoading(isLoading: true)
            self.vehicleViewModal.getVehicleForCoordinates(coordinates: mapCenter)
          }
        }
      }
}
