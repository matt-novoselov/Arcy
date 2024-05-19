//
//  Test3.swift
//  Arcy
//
//  Created by Matt Novoselov on 02/05/24.
//

import SwiftUI

struct ArtifactDetailView: View {
    
    // Volume Model is responsible for controlling what Artifact should currently be displayed in the 3D volume
    @Environment(VolumeModelView.self) var volumeModel
    
    // Environment variable to open window by ID
    @Environment(\.openWindow) private var openWindow
    
    // Environment variable to dismiss the currently opened window
    @Environment(\.dismissWindow) private var dismissWindow
    
    // Property that controls if the Artifact is liked or not
    @State private var isLiked: Bool = false
    
    // Animated rotation of the model
    @State private var modelRotation = Angle.zero
    
    // Pass the selected Artifact to get information from
    let selectedArtifact: Artifact
    
    var body: some View {
        
        HStack{

            // 3D model and label
            ZStack(alignment: .bottom){
                
                // 3D model
                ArtifactModelView(modelName: selectedArtifact.modelName)
                    .rotation3DEffect(modelRotation, axis: .y)
                
                    // Animate model rotation on appearance
                    .onAppear {
                        withAnimation(.interpolatingSpring(duration: 1.5)){
                            modelRotation.degrees+=360
                        }
                    }
                
                // Make a binding to control the state of expansion of the volume through a toggle
                let isExpandedBinding = Binding(
                    get: { volumeModel.isExpanded },
                    set: { volumeModel.isExpanded = $0 }
                )
                
                // Collapse / Expand button
                Toggle(isOn: isExpandedBinding.animation()){
                    Label(volumeModel.isExpanded ? "Collapse" : "Expand", systemImage: volumeModel.isExpanded ? "arrow.down.right.and.arrow.up.left" : "arrow.up.left.and.arrow.down.right")
                }
                .toggleStyle(ButtonToggleStyle())
                
                // Open / Dismiss volume after user's action
                .onChange(of: volumeModel.isExpanded){
                    // Expand volume
                    if volumeModel.isExpanded{
                        volumeModel.nameOfModel = selectedArtifact.modelName
                        openWindow(id: "secondaryVolume")
                    } else{
                        // Collapse volume
                        dismissWindow(id: "secondaryVolume")
                    }
                }
                
            }
            .frame(maxWidth: 275, maxHeight: 325)
            .scaledToFit()
            
            // Information card
            VStack(alignment: .leading){
                // Artifact description wrapped in scroll view to ensure text is always readable
                ScrollView{
                    // Ensure that paragraphs are displayed correctly by replacing \\n with \n
                    Text(selectedArtifact.description.replacingOccurrences(of: "\\n", with: "\n"))
                        .foregroundStyle(.secondary)
                        .padding(.horizontal)
                }
                
                Spacer()
                
                // Action buttons
                HStack{
                    // Button to like the artifact
                    LikeButtonView(artifactID: selectedArtifact.artifactID)
                    
                    // Share Artifact's flat image and description
                    ShareLink(item: selectedArtifact.previewImage, preview: SharePreview("\(selectedArtifact.name)\n\n\(selectedArtifact.description)", image: selectedArtifact.previewImage)) {
                        Image(systemName: "square.and.arrow.up")
                    }
                }
                .padding(.horizontal)
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .padding(.vertical)
            .background(.regularMaterial, in: .rect(cornerRadius: 20))
            
            // Map that displays the position of the Artifact
            ExpandableMapView(selectedArtifact: selectedArtifact)
            
        }
        .padding(.all, 20)
        
        .navigationTitle(selectedArtifact.name)
        
        // Dismiss volume expanded window after exiting from the Detail view
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
