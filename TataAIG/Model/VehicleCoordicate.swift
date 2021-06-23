//
//  AppDelegate.swift
//  TataAIG
//
//  Created by Chaitanya Deshpande on 22/06/21.

import Foundation
struct VehicleCoordinate : Codable {
	var latitude : Double?
	var longitude : Double?

	enum CodingKeys: String, CodingKey {

		case latitude = "latitude"
		case longitude = "longitude"
	}

	init(from decoder: Decoder) throws {
		let values = try decoder.container(keyedBy: CodingKeys.self)
		latitude = try values.decodeIfPresent(Double.self, forKey: .latitude)
		longitude = try values.decodeIfPresent(Double.self, forKey: .longitude)
	}
    
    init(lat : Double, lon : Double) {
        self.latitude = lat
        self.longitude = lon
    }

}
