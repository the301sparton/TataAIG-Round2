//
//  AppDelegate.swift
//  TataAIG
//
//  Created by Chaitanya Deshpande on 22/06/21.
import Foundation
struct VehicleArray : Codable {
    let poiList : [Vehicle]?
    
    enum CodingKeys: String, CodingKey {
        case poiList = "poiList"
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        poiList = try values.decodeIfPresent([Vehicle].self, forKey: .poiList)
    }
    
}
