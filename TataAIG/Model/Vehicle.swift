//
//  AppDelegate.swift
//  TataAIG
//
//  Created by Chaitanya Deshpande on 22/06/21.

import Foundation
struct Vehicle : Codable {
    let id : Int?
    let coordinate : VehicleCoordinate?
    let fleetType : String?
    let heading : Double?
    
    enum CodingKeys: String, CodingKey {
        
        case id = "id"
        case coordinate = "coordinate"
        case fleetType = "fleetType"
        case heading = "heading"
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        id = try values.decodeIfPresent(Int.self, forKey: .id)
        coordinate = try values.decodeIfPresent(VehicleCoordinate.self, forKey: .coordinate)
        fleetType = try values.decodeIfPresent(String.self, forKey: .fleetType)
        heading = try values.decodeIfPresent(Double.self, forKey: .heading)
    }
    
}
