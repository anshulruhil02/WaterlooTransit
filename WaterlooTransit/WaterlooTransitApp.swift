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
        WindowGroup {
            TransitView()
        }
    }
}
