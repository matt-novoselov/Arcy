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
        Model3D(named: volumeModel.nameOfModel) { model in
            switch model {
            case .empty:
                // Display Progress View, while model is trying to load
                ProgressView()
                
            case .success(let resolvedModel3D):
                // Display loaded 3D model of an Artifact
                resolvedModel3D
                    .resizable()
                    .scaledToFit()
                
                // Add possibility of rotating the model through a custom modifier
                    .dragRotation(yawLimit: .degrees(180), pitchLimit: .degrees(180), sensitivity: 5)
                
            case .failure(let error):
                // Display error text if load failed
                Text(error.localizedDescription)
                
            @unknown default:
                EmptyView()
            }
        }
        .padding3D()
        .overlay{
            // Collapse button
            Button(action: {
                dismissWindow(id: "secondaryVolume")
            }, label: {
                Label("Collapse", systemImage: "arrow.down.right.and.arrow.up.left")
            })
            .font(.title)
            .glassBackgroundEffect()
//            .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .bottom)
        }
        
    }
}

#Preview {
    VolumetricModelView()
        .previewVariables()
}
