//
//  PlacementSettings.swift
//  ARForniture
//
//  Created by Pablo Aguirre on 05/08/24.
//

import SwiftUI
import RealityKit
import Combine

class PlacementSettings: ObservableObject {
    
    /// When the user selects a model in BrowseView, this property is ste
    @Published var selectedModel: Model? {
        willSet(newValue) {
            print("Setting selectedModel to \(String(describing: newValue?.name))")
        }
    }
    
    /// When the user taps confirm PlacementView, the value of selectedModel is asigned to confirmedModel
    @Published var confirmedModel: Model? {
        willSet(newValue) {
            guard let model = newValue else {
                print("Clearing confirmedModel")
                return
            }
            print("Setting confirmedModel to \(model.name)")
        }
    }
    
    /// This property retains the cancellable object for our SceneEvents.Update subscriber
    var sceneObserver: Cancellable?
    
}
