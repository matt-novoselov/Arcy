//
//  ModelView.swift
//  Arcy
//
//  Created by Matt Novoselov on 03/05/24.
//

import SwiftUI
import RealityKit

// Artifact Model View is a 3D representation of an Artifact
struct ArtifactModelView: View {
    
    // Name of the 3D model that represents the artifact
    // Note: Pass only the name of the model in the .usdz format without an extension itself
    // Example:
    // If the model in the Resource folder is named MyModel.usdz, you only need to pass MyModel
    let modelName: String
    
    // Allow rotation on y axis
    var allowYawRotation: Bool = false
    
    // Allow rotation on x axis
    var allowPitchRotation: Bool = false
    
    // Animate model opacity on appear
    @State private var modelOpacity: Double = 0
    
    var body: some View {
        
        // Display the 3D model of an Artifact
        Model3D(named: modelName) { model in
            model
                .resizable()
                .scaledToFit()
                .opacity(modelOpacity)
                .padding()
            
                // Add possibility of rotating the model through a custom modifier
                .dragRotation(yawLimit: .degrees(allowYawRotation ? 180 : 0), pitchLimit: .degrees(allowPitchRotation ? 180 : 0), sensitivity: 5)
            
                // Animate model opacity on appear
                .onAppear(){
                    withAnimation(.interpolatingSpring(duration: 1.5)){
                        modelOpacity = 1
                    }
                }
        } placeholder: {
            // Display placeholder while view loads
            ProgressView()
                .frame(height: 300)
        }
        .frame(height: 300)
        
    }
}

#Preview(windowStyle: .automatic) {
    ArtifactModelView(modelName: "Attic_red_figured_krater")
        .previewVariables()
}
