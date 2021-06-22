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
        super.viewDidLoad()
        vehicleViewModal.viewController = self
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
        return 100
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let mapVC : MapViewController = (Util.storyBoard.instantiateViewController(withIdentifier: "mapVC") as? MapViewController)!
        mapVC.vehicleArray = vehicleViewModal.vehicalArray
        mapVC.selectedVehicle = (vehicleViewModal.vehicalArray?.poiList![indexPath.row])!
        self.navigationController?.pushViewController(mapVC, animated: true)
    }

}

