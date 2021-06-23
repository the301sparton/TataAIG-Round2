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
        
        vehicleViewModal.viewController = self
        doUIConfig() // Setup UI
        setAllMarkers() // Add Markers on GoogleMap
        mapView?.delegate = self // Set GoogleMapViewDelegate
    }
    
    func doUIConfig() {
        //Show Loading Label
        toggleVisiblityForLoading(isLoading: true)
        
        //Google Map UI Setup
        let camera = GMSCameraPosition.camera(withLatitude: 19.0760, longitude: 72.8777, zoom: 10)
        mapView = GMSMapView.map(withFrame: self.view.frame, camera: camera)
        mapView?.settings.compassButton = true
        mapHolder.addSubview(mapView!)
        
        // PopOver View Setup
        mapHolder.bringSubviewToFront(bottomDetailView)
        bottomDetailView.layer.cornerRadius = 20
        bottomDetailView.clipsToBounds = true
        
        //Zoom to selected Item if vehicle is selected in tableView
        if let selectedVehicle = selectedVehicle {
            zoomToCoordinates(coordinate: selectedVehicle.coordinate!)
        }
    }
    
    func setAllMarkers() {
        if let vehicelList = vehicleViewModal.vehicalArray?.poiList {
            for vehicle in vehicelList {
                let position = CLLocationCoordinate2D(latitude: vehicle.coordinate?.latitude ?? 0, longitude: vehicle.coordinate?.longitude ?? 0)
                let marker = GMSMarker(position: position)
                marker.title = "Vehicel Id : \(String(describing: vehicle.id!))"
                
                // Add marker icon based on vehicel fleetType
                if vehicle.fleetType == "POOLING" {
                    marker.icon = UIImage.init(named: "carpool")
                }
                else {
                    marker.icon = UIImage.init(named: "taxi")
                }
                
                // Add Rotation to marker based on Heading's Value
                marker.rotation = CLLocationDegrees(vehicle.heading!)
                marker.map = mapView
            }
        }
    }
    
    func zoomToCoordinates(coordinate : VehicleCoordinate) {
        let camera = GMSCameraPosition.camera(withLatitude: coordinate.latitude ?? 0, longitude: coordinate.longitude ?? 0, zoom: 15)
        mapView?.animate(to: camera)
    }
    
    
    // -- Toggle Visiblity of Loading Label
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


//  ---- Subscribe to GMSMapViewDelegate Protocol ----
extension MapViewController : GMSMapViewDelegate {
    // Identify scrolling ended event
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
