//
//  ControlView.swift
//  ARForniture
//
//  Created by Pablo Aguirre on 04/08/24.
//

import SwiftUI

struct ControlView: View {
    @Binding var isControlsVisible: Bool
    
    var body: some View {
        VStack {
            ControlVisibilityToggleButton(isControlsVisible: $isControlsVisible)
            Spacer()
            if isControlsVisible {
                ControlButtonBar()
            }
        }
    }
}

struct ControlVisibilityToggleButton: View {
    @Binding var isControlsVisible: Bool
    
    var body: some View {
        HStack {
            Spacer()
            ZStack {
                Color.black.opacity(0.25)
                Button(action: { isControlsVisible.toggle() }) {
                    Image(systemName: isControlsVisible ? "rectangle" : "slider.horizontal.below.rectangle")
                        .font(.system(size: 25))
                        .foregroundStyle(.white)
                }
            }
            .frame(width: 40, height: 35)
        }
        .padding(.top, 45)
        .padding(.trailing, 20)
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
