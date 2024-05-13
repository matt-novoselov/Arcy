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
                
            case .failure(let error):
                // Display error text if load failed
                Text(error.localizedDescription)
                
            @unknown default:
                EmptyView()
            }
        }
        
    }
}

#Preview {
    VolumetricModelView()
        .previewVariables()
}
