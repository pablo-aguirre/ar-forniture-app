//
//  PlacementView.swift
//  ARForniture
//
//  Created by Pablo Aguirre on 05/08/24.
//

import SwiftUI

struct PlacementView: View {
    @EnvironmentObject var placementSettings: PlacementSettings
    
    var body: some View {
        HStack {
            Spacer()
            PlacementButton(systemIconName: "xmark.circle.fill") {
                print("Cancel placement button pressed.")
                placementSettings.selectedModel = nil
            }
            Spacer()
            PlacementButton(systemIconName: "checkmark.circle.fill") {
                print("Confirm placement button pressed.")
                placementSettings.confirmedModel = placementSettings.selectedModel
                placementSettings.selectedModel = nil
            }
            Spacer()
        }
        .padding(.bottom, 30)
    }
}

struct PlacementButton: View {
    let systemIconName: String
    let action: () -> Void
    
    var body: some View {
        Button(action: action) {
            Image(systemName: systemIconName)
                .font(.system(size: 50, weight: .light, design: .default))
                .foregroundStyle(.white)
                .buttonStyle(PlainButtonStyle())
        }
        .frame(width: 75, height: 75)
    }
}

#Preview {
    PlacementView()
}
