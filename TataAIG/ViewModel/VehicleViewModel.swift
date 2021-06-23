//
//  VehicleViewModel.swift
//  TataAIG
//
//  Created by Chaitanya Deshpande on 22/06/21.
//

import UIKit
class VehicleViewModel {
    var vehicalArray : VehicleArray?
    weak var viewController : ViewController?
    func getAllVehicles() {
        let coordinate = VehicleCoordinate(lat: 18.5204, lon: 73.8567)
        getVehicleForCoordinates(coordinates: coordinate)
    }
    
    func getVehicleForCoordinates(coordinates : VehicleCoordinate) {
        let url = Util.baseUrl + "p2Lat=\(String(describing: coordinates.latitude!))&p2Lon=\(String(describing: coordinates.longitude!))"
        print(url)
        URLSession.shared.dataTask(with: URL(string: url)!){
            (data, res, error) in
            if error == nil {
                if let data = data {
                    do {
                        self.vehicalArray  = try JSONDecoder().decode(VehicleArray.self, from: data)
                        if self.viewController != nil {
                            DispatchQueue.main.async {
                                self.viewController?.tableView.reloadData()
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
