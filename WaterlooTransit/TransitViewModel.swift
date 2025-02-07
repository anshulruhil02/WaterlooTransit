//
//  TransitViewModel.swift
//  WaterlooTransit
//
//  Created by Anshul Ruhil on 2025-01-31.
//

import Foundation

// MARK: TransitViewModel

class TransitViewModel: ObservableObject {
    
    // MARK: Internal
    
    init(transitService: TransitServiceProtocol) {
        self.transitService = transitService
    }
    
    @Published var vehicles: [VehiclePosition] = []
    var fetchTask: Task<Void, Never>?
    
    func startFetching() {
        guard fetchTask == nil else { return }
        
        fetchTask = Task(priority: .background) { [weak self] in
            guard let self = self else {
                return
            }
            await self.repeatedFetching()
        }
    }
    
    func stopFetching() {
        fetchTask?.cancel()
        fetchTask = nil
    }
    
    // MARK: Private
    
    private let transitService: TransitServiceProtocol
    private func repeatedFetching() async {
        while !Task.isCancelled {
            do {
                let collectVehicles = try await transitService.fetchData()
                await MainActor.run {
                    self.vehicles = collectVehicles
                }
            } catch {
                print("Error fetching data")
            }
            try? await Task.sleep(nanoseconds: 5_000_000_000)
        }
    }
}
