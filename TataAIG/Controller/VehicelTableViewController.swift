//
//  ViewController.swift
//  TataAIG
//
//  Created by Chaitanya Deshpande on 22/06/21.
//

import UIKit

class VehicelTableViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    var vehicleViewModal = VehicleViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        vehicleViewModal.viewController = self
        vehicleViewModal.getVehiclesInMumbaiPune() // Make API Call With ViewModel
        tableView.register(UINib(nibName: "VehicleCell", bundle: nil), forCellReuseIdentifier: "VehicleCell")
    }
}

extension VehicelTableViewController : UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        vehicleViewModal.vehicalArray?.poiList?.count ?? 0 // Return Number of Vehicels from ViewModel
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        // Create Custom Cell for TableView
        let cell = tableView.dequeueReusableCell(withIdentifier: "VehicleCell", for: indexPath) as? VehicleCell
        // Get Vehicle At IndexPath
        let vehicle : Vehicle = (vehicleViewModal.vehicalArray?.poiList![indexPath.row])!
        // SetUp View
        cell?.setVehicleData(vehicle: vehicle)
        return cell!
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100 // Fixed Height for each cell
    }
    
    // Row Tapped Callback --> UITableViewDelegate
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        // Show MapViewController
        let mapVC : MapViewController = (Util.storyBoard.instantiateViewController(withIdentifier: "mapVC") as? MapViewController)!
        mapVC.vehicleViewModal = vehicleViewModal //Pass ViewModel
        mapVC.selectedVehicle = (vehicleViewModal.vehicalArray?.poiList![indexPath.row])! //Pass Selected Vehicel
        self.navigationController?.pushViewController(mapVC, animated: true)
    }
    
}

