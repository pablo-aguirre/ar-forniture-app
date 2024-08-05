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
