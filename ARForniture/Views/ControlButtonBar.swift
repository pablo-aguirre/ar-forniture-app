//
//  ControlButtonBar.swift
//  ARForniture
//
//  Created by Pablo Aguirre on 05/08/24.
//

import SwiftUI

struct ControlButtonBar: View {
    @EnvironmentObject var placementSettings: PlacementSettings
    @Binding var isBrowseVisible: Bool
    
    var body: some View {
        HStack {
            MostRecentlyPlacedButton().hidden(placementSettings.recentlyPlaced.isEmpty)
            
            Spacer()
            
            ControlButton(systemIconName: "square.grid.2x2") {
                print("Browse button pressed")
                isBrowseVisible.toggle()
            }.sheet(isPresented: $isBrowseVisible) {
                BrowseView(isBrowseVisible: $isBrowseVisible)
            }
            
            Spacer()
            
            ControlButton(systemIconName: "slider.horizontal.3") {
                print("Settings button pressed")
            }
        }
        .frame(maxWidth: 500)
        .padding(30)
        .background(Color.black.opacity(0.25))
    }
}
