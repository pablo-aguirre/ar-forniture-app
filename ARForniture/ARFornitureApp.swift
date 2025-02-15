//
//  ARFornitureApp.swift
//  ARForniture
//
//  Created by Pablo Aguirre on 04/08/24.
//

import SwiftUI

@main
struct ARFornitureApp: App {
    @StateObject var placementSettings: PlacementSettings = .init()
    @StateObject var sessionSettings: SessionSettings = .init()
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(placementSettings)
                .environmentObject(sessionSettings)
        }
    }
}
