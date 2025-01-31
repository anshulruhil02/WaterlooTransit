//
//  TransitViewModel.swift
//  WaterlooTransit
//
//  Created by Anshul Ruhil on 2025-01-31.
//

import Foundation

// MARK: TransitViewModel

class TransitViewModel: ObservableObject {
    @Published var vehicles: [VehiclePosition] = []
    private let transitService: TransitServiceProtocol
    
    init(vehicles: [VehiclePosition], transitService: TransitServiceProtocol) {
        self.vehicles = vehicles
        self.transitService = transitService
    }
}
