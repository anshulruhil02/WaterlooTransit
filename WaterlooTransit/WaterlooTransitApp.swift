//
//  WaterlooTransitApp.swift
//  WaterlooTransit
//
//  Created by Anshul Ruhil on 2025-01-30.
//

import SwiftUI

@main
struct WaterlooTransitApp: App {
    var body: some Scene {
        let transitService = TransitService()
        let viewModel = TransitViewModel(transitService: transitService)
        WindowGroup {
            TransitView(transitViewModel: viewModel)
        }
    }
}
