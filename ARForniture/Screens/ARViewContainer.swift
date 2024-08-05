//
//  ARViewContainer.swift
//  ARForniture
//
//  Created by Pablo Aguirre on 04/08/24.
//

import SwiftUI
import RealityKit
import ARKit
import FocusEntity
import Combine

struct ARViewContainer: UIViewRepresentable {
    @EnvironmentObject var placementSettings: PlacementSettings
    @EnvironmentObject var sessionSettings: SessionSettings
    
    func makeUIView(context: Context) -> CustomARView {
        let arView = CustomARView(frame: .zero, sessionSettings: sessionSettings)
        
        self.placementSettings.sceneObserver = arView.scene.subscribe(to: SceneEvents.Update.self, { event in
            updateScene(for: arView)
        })
        
        return arView
    }
    
    func updateUIView(_ uiView: CustomARView, context: Context) {}
    
    private func updateScene(for arView: CustomARView) {
        arView.focusEntity?.isEnabled = (self.placementSettings.selectedModel != nil)
        
        if let confirmedModel = placementSettings.confirmedModel, let modelEntity = confirmedModel.modelEntity {
            place(modelEntity, in: arView)
            placementSettings.confirmedModel = nil
        }
    }
    
    private func place(_ modelEntity: ModelEntity, in arView: ARView) {
        let clonedEntity = modelEntity.clone(recursive: true)
        
        clonedEntity.generateCollisionShapes(recursive: true)
        arView.installGestures(for: clonedEntity)
        
        let anchorEntity = AnchorEntity(plane: .any)
        anchorEntity.addChild(clonedEntity)
        
        arView.scene.addAnchor(anchorEntity)
        print("Added modelEntity to the scene.")
    }
    
}

class CustomARView: ARView {
    
    var focusEntity: FocusEntity?
    var sessionSettings: SessionSettings
    
    private var peopleOcclusionCancellable: AnyCancellable?
    private var objectOcclusionCancellable: AnyCancellable?
    private var lidarDebugCancellable: AnyCancellable?
    
    required init(frame frameRect: CGRect, sessionSettings: SessionSettings) {
        self.sessionSettings = sessionSettings
        super.init(frame: frameRect)
        
        focusEntity = .init(on: self, focus: .classic)
        configure()
        initializeSettings()
        setupSubscribers()
    }
    
    required init(frame frameRect: CGRect) {
        fatalError("init(frame:) has not been implemented")
    }
    
    @MainActor required dynamic init?(coder decoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configure() {
        let configuration = ARWorldTrackingConfiguration()
        configuration.planeDetection = [.horizontal, .vertical]
        
        if ARWorldTrackingConfiguration.supportsSceneReconstruction(.mesh) {
            configuration.sceneReconstruction = .mesh
        }
        
        self.session.run(configuration)
    }
    
    private func initializeSettings() {
        self.updatePeopleOcclusion(isEnabled: sessionSettings.isPeopleOcclusionEnabled)
        self.updateObjectOcclusion(isEnabled: sessionSettings.isObjectsOcclusionEnabled)
        self.updateLidarDebug(isEnabled: sessionSettings.isLidarDebugEnabled)
    }
    
    private func setupSubscribers() {
        self.peopleOcclusionCancellable = sessionSettings.$isPeopleOcclusionEnabled.sink { [weak self] isEnabled in
            self?.updatePeopleOcclusion(isEnabled: isEnabled)
        }
        
        self.objectOcclusionCancellable = sessionSettings.$isObjectsOcclusionEnabled.sink { [weak self] isEnabled in
            self?.updateObjectOcclusion(isEnabled: isEnabled)
        }
        
        self.lidarDebugCancellable = sessionSettings.$isLidarDebugEnabled.sink { [weak self] isEnabled in
            self?.updateLidarDebug(isEnabled: isEnabled)
        }
    }
    
    private func updatePeopleOcclusion(isEnabled: Bool) {
        guard ARWorldTrackingConfiguration.supportsFrameSemantics(.personSegmentationWithDepth) else { return }
        guard let configuration = self.session.configuration as? ARWorldTrackingConfiguration else { return }
        
        if configuration.frameSemantics.contains(.personSegmentationWithDepth) {
            configuration.frameSemantics.remove(.personSegmentationWithDepth)
        } else {
            configuration.frameSemantics.insert(.personSegmentationWithDepth)
        }
        
        self.session.run(configuration)
    }
    
    private func updateObjectOcclusion(isEnabled: Bool) {
        if self.environment.sceneUnderstanding.options.contains(.occlusion) {
            self.environment.sceneUnderstanding.options.remove(.occlusion)
        } else {
            self.environment.sceneUnderstanding.options.insert(.occlusion)
        }
    }
    
    private func updateLidarDebug(isEnabled: Bool) {
        if self.debugOptions.contains(.showSceneUnderstanding) {
            self.debugOptions.remove(.showSceneUnderstanding)
        } else {
            self.debugOptions.insert(.showSceneUnderstanding)
        }
    }
    
}
