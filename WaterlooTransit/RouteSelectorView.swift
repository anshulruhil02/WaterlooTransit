//
//  RouteSelectorView.swift
//  WaterlooTransit
//
//  Created by Anshul Ruhil on 2025-03-01.
//

import SwiftUI

struct RouteSelectorView: View {
    var body: some View {
        VStack{
            Text("Routes")
                .font(.title)
                .padding()
            
            Divider()
            
            List(routes, id: \.self) { route in
                HStack {
                    Button(action: {
                        viewModel.toggleSelection(route: route)
                    }) {
                        Image(systemName: viewModel.selectedRoutes.contains(route) ? "checkmark.square.fill" : "square")
                    }
                    Text(route)
                }
                .padding()
            }
        }
    }
        
    
    // MARK: Internal
    var routes: [String]
    @ObservedObject var viewModel: TransitViewModel
}
