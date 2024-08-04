//
//  BrowseView.swift
//  ARForniture
//
//  Created by Pablo Aguirre on 04/08/24.
//

import SwiftUI

struct BrowseView: View {
    @Binding var isBrowseVisible: Bool
    
    var body: some View {
        NavigationView {
            ScrollView {
                
            }
            .navigationTitle("Browse")
            .toolbar(content: {
                ToolbarItem(placement: .topBarTrailing) {
                    Button("Done") {
                        isBrowseVisible.toggle()
                    }.bold()
                }
            })
        }
    }
}
