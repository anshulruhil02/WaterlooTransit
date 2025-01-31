//
//  ContentView.swift
//  WaterlooTransit
//
//  Created by Anshul Ruhil on 2025-01-30.
//

import SwiftUI

struct TransitView: View {
    @State var vehicles: [VehiclePosition] = []
    let gtfsURL = "https://webapps.regionofwaterloo.ca/api/grt-routes/api/vehiclepositions"

    var body: some View {
        VStack {
            List(vehicles) { vehicle in
                HStack{
                    Text("Vehicle Route: \(vehicle.route)")
                    Text("Vehicle latitude: \(vehicle.latitude)")
                    Text("Vehicle longitude: \(vehicle.longitude)")
                }
            }
        }
        .onAppear {
            Task{
                let data = try  await TransitService.shared.fetchData(url: gtfsURL)
                vehicles = data
                print("Vehicle data: \(vehicles)")
            }
        }
    }
}

#Preview {
    TransitView()
}
