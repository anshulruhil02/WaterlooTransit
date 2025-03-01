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
            Text("Last update: \(lastUpdated)")
            
            List(transitViewModel.selectedCollectionVehicles.keys.sorted(), id: \.self) { route in
                VStack{
                    Text("Route: \(route)")
                        .font(.title)
                    ForEach(transitViewModel.selectedCollectionVehicles[route] ?? []) { vehicle in
                        HStack {
                            Text("id: \(vehicle.id)")
                            Text("Lat: \(vehicle.latitude)")
                            Text("Long: \(vehicle.longitude)")
                        }
                    }
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
        .sheet(isPresented: $routeSheet) {
            RouteSelectorView(routes: transitViewModel.routes.keys.sorted(), viewModel: transitViewModel)
                .presentationDetents([.fraction(0.1), .medium, .large])
                .presentationDragIndicator(.visible)
                .interactiveDismissDisabled()
        }
    }
    
    // MARK: Internal
    
    let gtfsURL = "https://webapps.regionofwaterloo.ca/api/grt-routes/api/vehiclepositions"
    @ObservedObject var transitViewModel: TransitViewModel
    @State var lastUpdated: String = "Never"
    
    // MARK: Private
    @State private var routeSheet = true
}
