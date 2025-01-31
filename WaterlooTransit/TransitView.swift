//
//  ContentView.swift
//  WaterlooTransit
//
//  Created by Anshul Ruhil on 2025-01-30.
//

import SwiftUI

struct TransitView: View {
    let gtfsURL = "https://webapps.regionofwaterloo.ca/api/grt-routes/api/vehiclepositions"
    @ObservedObject var transitViewModel: TransitViewModel

    var body: some View {
        VStack {
            List(transitViewModel.vehicles) { vehicle in
                HStack{
                    Text("Vehicle Route: \(vehicle.route)")
                    Text("Vehicle latitude: \(vehicle.latitude)")
                    Text("Vehicle longitude: \(vehicle.longitude)")
                }
            }
        }
    }
}

//#Preview {
//    TransitView()
//}
