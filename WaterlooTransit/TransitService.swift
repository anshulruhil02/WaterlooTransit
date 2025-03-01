//
//  TransitService.swift
//  WaterlooTransit
//
//  Created by Anshul Ruhil on 2025-01-30.
//

import Foundation
import SwiftProtobuf

protocol TransitServiceProtocol {
    func fetchData() async throws -> [VehiclePosition]
}

class TransitService: TransitServiceProtocol {
    let gtfsURL = "https://webapps.regionofwaterloo.ca/api/grt-routes/api/vehiclepositions"
    
    func fetchData() async throws -> [VehiclePosition] {
        do {
            guard let url = URL(string: gtfsURL) else {
                throw URLError(.badURL)
            }
            
            let (data, _) = try await URLSession.shared.data(from: url)
//            print("data: \(data)")
            return try await decodeGTFS(data: data)
        } catch {
            print("Error fetching the data")
            return []
        }
    }
    
    private func decodeGTFS(data: Data) async throws -> [VehiclePosition] {
        do {
            let feed = try TransitRealtime_FeedMessage(serializedBytes: data)
            var vehicles: [VehiclePosition] = []
            
            for entity in feed.entity {
                if entity.hasVehicle {
                    let vehicle = entity.vehicle
                    let position = vehicle.position
                    let vehiclePosition = VehiclePosition(
                        id: vehicle.vehicle.id,
                        route: vehicle.trip.routeID,
                        latitude: position.latitude,
                        longitude: position.longitude
                    )
                    vehicles.append(vehiclePosition)
                }
            }
//            print("returns: \(vehicles)")
            
            return vehicles
        } catch {
            print("Error decoding GTFS Realtime data: \(error)")
            return []
        }
    }
}
