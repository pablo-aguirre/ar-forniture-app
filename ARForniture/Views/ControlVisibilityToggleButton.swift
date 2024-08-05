//
//  ControlVisibilityToggleButton.swift
//  ARForniture
//
//  Created by Pablo Aguirre on 05/08/24.
//

import SwiftUI

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
