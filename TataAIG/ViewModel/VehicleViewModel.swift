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
        URLSession.shared.dataTask(with: URL(string: "https://fake-poi-api.mytaxi.com/?p1Lat=18.910000&p1Lon=72.809998&p2Lat=18.5204&p2Lon=73.8567")!){
            (data, res, error) in
            if error == nil {
                if let data = data {
                    do {
                        self.vehicalArray  = try JSONDecoder().decode(VehicleArray.self, from: data)
                        DispatchQueue.main.async {
                            self.viewController?.tableView.reloadData()
                        }
                    }
                    catch {
                        
                    }
                }
            }
            else {
                print(error?.localizedDescription as Any)
            }
        }.resume()
    }
}
