//
//  SessionSettings.swift
//  ARForniture
//
//  Created by Pablo Aguirre on 05/08/24.
//

import Foundation

class SessionSettings: ObservableObject {
    @Published var isPeopleOcclusionEnabled: Bool = false
    @Published var isObjectsOcclusionEnabled: Bool = false
    @Published var isLidarDebugEnabled: Bool = false
}
