//
//  View+Extensions.swift
//  ARForniture
//
//  Created by Pablo Aguirre on 05/08/24.
//

import SwiftUI

extension View {
    
    @ViewBuilder func hidden(_ shouldHide: Bool) -> some View {
        switch shouldHide {
        case true: self.hidden()
        case false: self
        }
    }
    
}
