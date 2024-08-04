//
//  ControlView.swift
//  ARForniture
//
//  Created by Pablo Aguirre on 04/08/24.
//

import SwiftUI

struct ControlView: View {
    var body: some View {
        VStack {
            ControlVisibilityToggleButton()
            Spacer()
            ControlButtonBar()
        }
    }
}

struct ControlVisibilityToggleButton: View {
    var body: some View {
        HStack {
            
        }
    }
}

struct ControlButtonBar: View {
    var body: some View {
        HStack {
            ControlButton(systemIconName: "clock.fill") {
                print("MostRecentlyPlaced button pressed")
            }
            Spacer()
            ControlButton(systemIconName: "square.grid.2x2") {
                print("Browse button pressed")
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

#Preview {
    ControlView()
}
