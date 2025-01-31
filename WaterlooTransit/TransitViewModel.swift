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
    
    init(transitService: TransitServiceProtocol) {
        self.transitService = transitService
        Task {
            let collectVehicles = try await transitService.fetchData()
            DispatchQueue.main.async {
                self.vehicles = collectVehicles
            }
        }
    }
}
