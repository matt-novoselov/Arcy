//
//  CubeView.swift
//  Arcy
//
//  Created by Matt Novoselov on 11/05/24.
//

import SwiftUI
import RealityKit

// Volumetric Model View is used to display 3D model of the Artifacts in the Detail View
struct VolumetricModelView: View {
    
    // Volume Model is responsible for controlling what Artifact should currently be displayed in the 3D volume
    @Environment(VolumeModelView.self)
    private var volumeModel
    
    // Environment variable to dismiss the currently opened window
    @Environment(\.dismissWindow) private var dismissWindow
    
    var body: some View {
        
        // Display the 3D model of an Artifact
        ArtifactModelView(modelName: volumeModel.nameOfModel, allowYawRotation: true, allowPitchRotation: true)
            .overlay{
                // Collapse button
                Button(action: {
                    withAnimation{
                        volumeModel.isExpanded = false
                        dismissWindow(id: "secondaryVolume")
                    }
                }, label: {
                    Label("Collapse", systemImage: "arrow.down.right.and.arrow.up.left")
                })
                .font(.title)
                .glassBackgroundEffect()
            }
        
    }
}
