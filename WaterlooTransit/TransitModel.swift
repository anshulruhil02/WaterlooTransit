//
//  TransitModel.swift
//  WaterlooTransit
//
//  Created by Anshul Ruhil on 2025-01-31.
//

import Foundation

// MARK: VehiclePosition

struct VehiclePosition: Identifiable {
    let id: String
    var route: String
    var latitude: Float
    var longitude: Float
}
