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
    @Published var routes: [String: [VehiclePosition]] = [:]
    @Published var selectedRoutes: Set<String> = []
    
    var fetchTask: Task<Void, Never>?
    
    var selectedCollectionVehicles: [String: [VehiclePosition]] {
        let filteredVehicles = vehicles.filter { selectedRoutes.contains( $0.route ) }
        return Dictionary(grouping: filteredVehicles, by: { $0.route })
    }
    
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
    
    func toggleSelection(route: String) {
        print("Toggling route: \(route)")
        if selectedRoutes.contains(route) {
            selectedRoutes.remove(route)
        } else {
            selectedRoutes.insert(route)
        }
    }
    
    // MARK: Private
    
    private let transitService: TransitServiceProtocol
    private func repeatedFetching() async {
        while !Task.isCancelled {
            do {
                let collectVehicles = try await transitService.fetchData()
                let routesCollection = Dictionary(grouping: collectVehicles, by: { $0.route })
                await MainActor.run {
                    self.vehicles = collectVehicles
                    self.routes = routesCollection
                }
            } catch {
                print("Error fetching data")
            }
            try? await Task.sleep(nanoseconds: 5_000_000_000)
        }
    }
}
