//
//  ContentView.swift
//  WaterlooTransit
//
//  Created by Anshul Ruhil on 2025-01-30.
//

import SwiftUI

struct TransitView: View {
    var body: some View {
        VStack {
            Text("LAst update: \(lastUpdated)")
            
            List(transitViewModel.vehicles) { vehicle in
                HStack{
                    Text("Vehicle Route: \(vehicle.route)")
                    Text("Vehicle latitude: \(vehicle.latitude)")
                    Text("Vehicle longitude: \(vehicle.longitude)")
                }
            }
        }
        .onAppear {
            transitViewModel.startFetching()
        }
        .onDisappear {
            transitViewModel.stopFetching()
        }
        .onReceive(transitViewModel.$vehicles) { _ in
            DispatchQueue.main.async {
                lastUpdated = DateFormatter.localizedString(from: Date(), dateStyle: .none, timeStyle: .medium)
            }
        }
    }
    
    // MARK: Internal
    
    let gtfsURL = "https://webapps.regionofwaterloo.ca/api/grt-routes/api/vehiclepositions"
    @ObservedObject var transitViewModel: TransitViewModel
    @State var lastUpdated: String = "Never"
}

//#Preview {
//    TransitView()
//}
