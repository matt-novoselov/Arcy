//
//  Test3.swift
//  Arcy
//
//  Created by Matt Novoselov on 02/05/24.
//

import SwiftUI

struct ArtifactDetailView: View {
    
    @Environment(VolumeModelView.self) var volumeModel
    
    @Environment(\.openWindow) private var openWindow
    
    // Environment variable to dismiss the currently opened window
    @Environment(\.dismissWindow) private var dismissWindow
    
    @State private var isLiked: Bool = false
    
    // Animated rotation of the model
    @State private var modelRotation = Angle.zero

    let selectedArtifact: Artifact
    
    var body: some View {
        
        HStack{
            
            @Bindable var model = volumeModel
            
            // 3D model and label
            ZStack(alignment: .bottom){
                
                // 3D model
                ArtifactModelView(modelName: selectedArtifact.modelName)
                    .rotation3DEffect(modelRotation, axis: .y)
                    .onAppear {
                        withAnimation(.interpolatingSpring(duration: 1.5)){
                            modelRotation.degrees+=360
                        }
                    }
                
                let isExpandedBinding = Binding(
                    get: { volumeModel.isExpanded },
                    set: { volumeModel.isExpanded = $0 }
                )
                
                // Collapse / Expand button
                Toggle(isOn: isExpandedBinding.animation()){
                    Label(volumeModel.isExpanded ? "Collapse" : "Expand", systemImage: volumeModel.isExpanded ? "arrow.down.right.and.arrow.up.left" : "arrow.up.left.and.arrow.down.right")
                }
                
                .toggleStyle(ButtonToggleStyle())
                
                .onChange(of: volumeModel.isExpanded){
                    if volumeModel.isExpanded{
                        volumeModel.nameOfModel = selectedArtifact.modelName
                        openWindow(id: "secondaryVolume")
                    } else{
                        dismissWindow(id: "secondaryVolume")
                    }
                }
                
            }
            .frame(height: 300)
            
            // Information card
            VStack(alignment: .leading){
                // Title and description
                VStack(alignment: .leading){
                    Text(selectedArtifact.name)
                        .font(.largeTitle)
                    
                    Text(selectedArtifact.description.replacingOccurrences(of: "\\n", with: "\n"))
                        .foregroundStyle(.secondary)
                }
                .padding()
                .background(.regularMaterial, in: .rect(cornerRadius: 20))
                
                // Action buttons
                HStack{
                    ShareLink(item: selectedArtifact.previewImage, preview: SharePreview("\(selectedArtifact.name)\n\n\(selectedArtifact.description)", image: selectedArtifact.previewImage)) {
                        Image(systemName: "square.and.arrow.up")
                    }
                    
                    LikeButtonView(artifactID: selectedArtifact.artifactID)
                }
            }
            .frame(width: 400)
            
            // Map
            ExpandableMapView(selectedArtifact: selectedArtifact)
            
        }
        .padding(.all, 20)
        
        .onDisappear {
            dismissWindow(id: "secondaryVolume")
            volumeModel.isExpanded = false
        }
        
    }
}

#Preview(windowStyle: .automatic) {
    ArtifactDetailView(selectedArtifact: ArtifactsCollection().artifacts.first!)
        .previewVariables()
}
