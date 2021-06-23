//
//  Util.swift
//  TataAIG
//
//  Created by Chaitanya Deshpande on 22/06/21.
//

import Foundation
import UIKit

struct  Util {
    //Please Enter A New Api Key
    static let gmapAPIKey : String = "AIzaSyCndvg_iZr4qVg3t6zJDp1RCsiMjkBQcyI"
    static let baseUrl : String = "https://fake-poi-api.mytaxi.com/?p1Lat=18.910000&p1Lon=72.809998&"
    static let mumbaiPuneCoordinate = VehicleCoordinate(lat: 18.5204, lon: 73.8567)
    static let storyBoard: UIStoryboard = {
        return UIStoryboard.init(name: "Main", bundle: nil)
    }()
    
}


