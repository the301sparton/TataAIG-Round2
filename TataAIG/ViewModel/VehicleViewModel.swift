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
    
    func getVehiclesInMumbaiPune() {
        
        getVehicleForCoordinates(coordinates: Util.mumbaiPuneCoordinate){
            (result) in
        }
    }
    
    func getVehicleForCoordinates(coordinates : VehicleCoordinate, completion:@escaping (VehicleArray) -> Void) {
        let url = Util.baseUrl + "p2Lat=\(String(describing: coordinates.latitude!))&p2Lon=\(String(describing: coordinates.longitude!))"
        URLSession.shared.dataTask(with: URL(string: url)!){
            (data, res, error) in
            if error == nil {
                if let data = data {
                    do {
                        self.vehicalArray  = try JSONDecoder().decode(VehicleArray.self, from: data)
                        if let topVC = self.viewController as? VehicelTableViewController {
                            DispatchQueue.main.async {
                                topVC.tableView.reloadData()
                            }
                        }
                        
                        if let topVC = self.viewController as? MapViewController {
                            DispatchQueue.main.async {
                                topVC.toggleVisiblityForLoading(isLoading: false)
                                topVC.setAllMarkers()
                            }
                        }
                        completion(self.vehicalArray!)
                    }
                    catch {
                        print(error.localizedDescription)
                    }
                }
            }
            else {
                print(error?.localizedDescription as Any)
            }
        }.resume()
    }
}
