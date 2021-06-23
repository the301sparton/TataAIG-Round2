//
//  VehicleCell.swift
//  TataAIG
//
//  Created by Chaitanya Deshpande on 22/06/21.
//
import Foundation
import UIKit

class VehicleCell: UITableViewCell {
    
    @IBOutlet weak var labelId: UILabel!
    @IBOutlet weak var labelType: UILabel!
    @IBOutlet weak var vehicleImage: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    func setVehicleData(vehicle : Vehicle) {
        if let id = vehicle.id {
            self.labelId.text = "Vehicle Number : \(id)"
        }
        if let type = vehicle.fleetType {
            self.labelType.text = "Vehicle Type : " + type
            
            // Add Image based on vehicel fleetType
            if type == "POOLING" {
                self.imageView?.image = UIImage.init(named: "carpool")
            }
            else {
                self.imageView?.image = UIImage.init(named: "taxi")
                
            }
        }
    }
    
}
