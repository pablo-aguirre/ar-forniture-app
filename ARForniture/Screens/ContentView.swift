//
//  ContentView.swift
//  ARForniture
//
//  Created by Pablo Aguirre on 04/08/24.
//

import SwiftUI
import RealityKit

struct ContentView: View {
    @EnvironmentObject var placementSettings: PlacementSettings
    @State private var isControlsVisible: Bool = false
    @State private var showBrowse: Bool = false
    
    var body: some View {
        ZStack(alignment: .bottom) {
            ARViewContainer()
            if placementSettings.selectedModel == nil {
                ControlView(isControlsVisible: $isControlsVisible, isBrowseVisible: $showBrowse)
            } else {
                PlacementView()
            }
        }
        .ignoresSafeArea()
    }
}

#Preview {
    ContentView()
        .environmentObject(PlacementSettings())
}
