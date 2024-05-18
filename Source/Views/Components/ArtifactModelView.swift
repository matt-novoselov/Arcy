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
    
    // Volume Model is responsible for controlling what Artifact should currently be displayed in the 3D volume
    @Environment(VolumeModelView.self)
    private var volumeModel
    
    // Environment variable to dismiss the currently opened window
    @Environment(\.dismissWindow) private var dismissWindow
    
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
        
        if let fileURL = Bundle.main.url(forResource: modelName, withExtension: "usdz"){
            // Display the 3D model of an Artifact
            Model3D(named: fileURL.lastPathComponent) { model in
                switch model {
                case .empty:
                    // Display placeholder while view loads
                    ProgressView()
                    
                case .success(let resolvedModel3D):
                    resolvedModel3D
                        .resizable()
                        .scaledToFit()
                        .opacity(modelOpacity)
                        .padding3D()
                    
                    // Add possibility of rotating the model through a custom modifier
                        .dragRotation(yawLimit: .degrees(allowYawRotation ? 180 : 0), pitchLimit: .degrees(allowPitchRotation ? 180 : 0), sensitivity: 5)
                    
                    // Animate model opacity on appear
                        .onAppear(){
                            withAnimation(.interpolatingSpring(duration: 1.5)){
                                modelOpacity = 1
                            }
                        }
                    
                case .failure(let error):
                    Text(error.localizedDescription)
                    
                @unknown default:
                    EmptyView()
                }
            }
        }
        else{
            Text("3D model not found")
                .foregroundStyle(.red)
                .fontWeight(.bold)
                .onAppear{
                    // Try to fix the problem
                    volumeModel.isExpanded = false
                    volumeModel.nameOfModel = ""
                    dismissWindow(id: "secondaryVolume")
                }
        }
    }
}

#Preview(windowStyle: .automatic) {
    ArtifactModelView(modelName: "Terracotta_figurine_of_a_seated_goddess")
        .previewVariables()
}
