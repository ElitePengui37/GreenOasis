//
//  StoreLocations.swift
//  GreenOasisGardeningCentre
//
//  Created by Daniel Sergeev on 13/5/2025.
//

import Foundation

struct StoreLocations: Codable, Identifiable
{
    let name: String
    let lat: Double
    let long: Double
    
    var id: String { name }
}
