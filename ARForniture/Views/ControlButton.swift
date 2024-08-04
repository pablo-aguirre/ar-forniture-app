//
//  ControlButton.swift
//  ARForniture
//
//  Created by Pablo Aguirre on 04/08/24.
//

import SwiftUI

struct ControlButton: View {
    let systemIconName: String
    let action: () -> Void
    
    var body: some View {
        Button(action: action, label: {
            Image(systemName: systemIconName)
                .font(.system(size: 35))
                .foregroundStyle(.white)
                .buttonStyle(PlainButtonStyle())
        })
    }
}
