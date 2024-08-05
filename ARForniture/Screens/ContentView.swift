//
//  ContentView.swift
//  ARForniture
//
//  Created by Pablo Aguirre on 04/08/24.
//

import SwiftUI
import RealityKit

struct ContentView: View {
    @State private var isControlsVisible: Bool = false
    @State private var showBrowse: Bool = false
    
    var body: some View {
        ZStack(alignment: .bottom) {
            ARViewContainer()
            ControlView(isControlsVisible: $isControlsVisible, isBrowseVisible: $showBrowse)
        }
        .ignoresSafeArea()
    }
}

#Preview {
    ContentView()
}
