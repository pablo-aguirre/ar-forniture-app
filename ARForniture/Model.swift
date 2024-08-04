//
//  Model.swift
//  ARForniture
//
//  Created by Pablo Aguirre on 04/08/24.
//

import Foundation
import SwiftUI
import RealityKit
import Combine

enum ModelCategory: CaseIterable {
    case table
    case chair
    case decor
    case light
    
    var label: String {
        get {
            switch self {
            case .table:
                return "Tables"
            case .chair:
                return "Chairs"
            case .decor:
                return "Decor"
            case .light:
                return "Lights"
            }
        }
    }
}

class Model: Identifiable {
    var name: String
    var category: ModelCategory
    var thumbnail: UIImage
    var modelEntity: ModelEntity?
    var scaleCompensation: Float
    
    init(name: String, category: ModelCategory, scaleCompensation: Float = 1.0) {
        self.name = name
        self.category = category
        self.thumbnail = UIImage(named: name) ?? UIImage(systemName: "photo")!
        self.scaleCompensation = scaleCompensation
    }
}

struct Models {
    var all: [Model] = []
    
    init() {
        let cupSaucerSet = Model(name: "cup_saucer_set", category: .decor)
        let redChair = Model(name: "redchair", category: .chair)
        let teaPot = Model(name: "teapot", category: .decor)
        
        self.all += [cupSaucerSet, redChair, teaPot]
    }
    
    func get(by category: ModelCategory) -> [Model] {
        return all.filter { $0.category == category }
    }
}
