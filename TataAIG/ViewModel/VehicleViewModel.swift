//
//  VehicleViewModel.swift
//  TataAIG
//
//  Created by Chaitanya Deshpande on 22/06/21.
//

import UIKit
class VehicleViewModel {
    
    var vehicalArray : VehicleArray?
    weak var viewController : UIViewController?
    
    func getAllVehicles() {
        let coordinate = VehicleCoordinate(lat: 18.5204, lon: 73.8567)
        getVehicleForCoordinates(coordinates: coordinate)
    }
    
    func getVehicleForCoordinates(coordinates : VehicleCoordinate) {
        let url = Util.baseUrl + "p2Lat=\(String(describing: coordinates.latitude!))&p2Lon=\(String(describing: coordinates.longitude!))"
        URLSession.shared.dataTask(with: URL(string: url)!){
            (data, res, error) in
            if error == nil {
                if let data = data {
                    do {
                        self.vehicalArray  = try JSONDecoder().decode(VehicleArray.self, from: data)
                        if let topVC = self.viewController as? ViewController {
                            DispatchQueue.main.async {
                                topVC.tableView.reloadData()
                            }
                        }
                        
                        if let topVC = self.viewController as? MapViewController {
                            DispatchQueue.main.async {
                                topVC.numVehiclesFoundLabel.text = "Found \(String(describing: self.vehicalArray!.poiList!.count)) Vehicles"
                                topVC.setAllMarkers()
                            }
                        }
                        
                    }
                    catch {
                        print(error)
                    }
                }
            }
            else {
                print(error?.localizedDescription as Any)
            }
        }.resume()
    }
}
