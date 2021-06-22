//
//  ViewController.swift
//  TataAIG
//
//  Created by Chaitanya Deshpande on 22/06/21.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    var vehicleViewModal = VehicleViewModel()
    
    override func viewDidLoad() {
        vehicleViewModal.viewController = self
        super.viewDidLoad()
        vehicleViewModal.getAllVehicles()
        tableView.register(UINib(nibName: "VehicleCell", bundle: nil), forCellReuseIdentifier: "VehicleCell")
    }
}

extension ViewController : UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        vehicleViewModal.vehicalArray?.poiList?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "VehicleCell", for: indexPath) as? VehicleCell
        
        let vehicle : Vehicle = (vehicleViewModal.vehicalArray?.poiList![indexPath.row])!
        
        cell?.setVehicleData(vehicle: vehicle)
        return cell!
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    }

}

