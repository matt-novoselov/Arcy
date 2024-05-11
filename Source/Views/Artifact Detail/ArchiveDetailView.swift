//
//  Test3.swift
//  Arcy
//
//  Created by Matt Novoselov on 02/05/24.
//

import SwiftUI

struct ArchiveDetailView: View {
    
    @Environment(VolumeModelView.self) var volumeModel
    
    @Environment(\.openWindow) private var openWindow
    @Environment(\.dismissWindow) private var dismissWindow
    
    @State private var isLiked: Bool = false
    
    // Animated rotation of the model
    @State private var modelRotation = Angle.zero
    
    let selectedArtifact: Artifact
    
    var body: some View {
        
        HStack{
            
            @Bindable var model = volumeModel
            
            //            // 3D model and label
            //            ZStack(alignment: .bottom){
            //
            //                // 3D model
            //                ArtifactModelView(modelName: selectedArtifact.modelName)
            //                    .rotation3DEffect(modelRotation, axis: .y)
            //                    .onAppear(){
            //                        withAnimation(.interpolatingSpring(duration: 1.5)){
            //                            modelRotation.degrees+=360
            //                        }
            //                    }
            //
            //                // Label
            //                Button(action: {}, label: {
            //                    Label("Expand", systemImage: "arrow.up.left.and.arrow.down.right")
            //                })
            //            }
            //            .frame(height: 300)
            
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
        
        .onAppear{
            openWindow(id: "secondaryVolume")
            volumeModel.nameOfModel = selectedArtifact.modelName
        }
        
        .onDisappear {
            dismissWindow(id: "secondaryVolume")
        }
        
    }
}

#Preview(windowStyle: .automatic) {
    ArchiveDetailView(selectedArtifact: ArtifactsCollection().artifacts.first!)
        .environment(VolumeModelView())
}
