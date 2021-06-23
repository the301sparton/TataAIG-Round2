//
//  MainViewController.swift
//  TataAIG
//
//  Created by Chaitanya Deshpande on 22/06/21.
//

import UIKit

class MainViewController: UIViewController {
    
    @IBOutlet weak var googleMapButton: UIButton!
    @IBOutlet weak var vehicleListButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do UI Config
        vehicleListButton.layer.cornerRadius = 10
        googleMapButton.layer.cornerRadius = 10
        
        vehicleListButton.clipsToBounds = true
        googleMapButton.clipsToBounds = true
    }
}
