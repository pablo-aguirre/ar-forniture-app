//
//  ContentView.swift
//  ARForniture
//
//  Created by Pablo Aguirre on 04/08/24.
//

import SwiftUI
import RealityKit

struct ContentView: View {
    var body: some View {
        ZStack(alignment: .bottom) {
            ARViewContainer()
            ControlButtonBar()
        }
        .ignoresSafeArea()
    }
}

#Preview {
    ContentView()
}
