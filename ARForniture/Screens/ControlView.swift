//
//  ControlView.swift
//  ARForniture
//
//  Created by Pablo Aguirre on 04/08/24.
//

import SwiftUI

struct ControlView: View {
    @Binding var isControlsVisible: Bool
    @Binding var isBrowseVisible: Bool
    
    var body: some View {
        VStack {
            ControlVisibilityToggleButton(isControlsVisible: $isControlsVisible)
            Spacer()
            if isControlsVisible {
                ControlButtonBar(isBrowseVisible: $isBrowseVisible)
            }
        }
    }
}


struct MostRecentlyPlacedButton: View {
    @EnvironmentObject var placementSettings: PlacementSettings
    
    var body: some View {
        Button(action: {
            print("Most recently placed button pressed.")
            placementSettings.selectedModel = placementSettings.recentlyPlaced.last
        }, label: {
            if let mostRecentlyPlacedModel = placementSettings.recentlyPlaced.last {
                Image(uiImage: mostRecentlyPlacedModel.thumbnail)
                    .resizable()
                    .frame(width: 46, height: 46)
                    .aspectRatio(contentMode: .fit)
                    .presentationCornerRadius(8.0)
            } else {
                Image(systemName: "clock.fill")
                    .font(.system(size: 35))
                    .foregroundStyle(.white)
                    .buttonStyle(PlainButtonStyle())
            }
        })
    }
}
