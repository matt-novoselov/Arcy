//
//  Test3.swift
//  Arcy
//
//  Created by Matt Novoselov on 02/05/24.
//

import SwiftUI
import RealityKit

struct ArchiveDetailView: View {
    
    @State private var isLiked: Bool = false
    
    // Animated rotation of the model
    @State private var modelRotation = Angle.zero
    
    var artifact: Artifact
    
    var body: some View {
        
        HStack{
            
            // 3D model and label
            ZStack(alignment: .bottom){
                
                // 3D model
                ArtifactModelView(modelName: artifact.modelName)
                    .rotation3DEffect(modelRotation, axis: .y)
                    .onAppear(){
                        withAnimation(.interpolatingSpring(duration: 1.5)){
                            modelRotation.degrees+=360
                        }
                    }
                
                // Label
                Button(action: {}, label: {
                    Label("Expand", systemImage: "arrow.up.left.and.arrow.down.right")
                })
            }
            .frame(height: 300)
            
            // Information card
            VStack(alignment: .leading){
                // Title and description
                VStack(alignment: .leading){
                    Text(artifact.name)
                        .font(.largeTitle)
                    
                    Text(artifact.description)
                        .foregroundStyle(.secondary)
                }
                .padding()
                .background(.regularMaterial, in: .rect(cornerRadius: 20))
                
                // Action buttons
                HStack{
                    ShareLink(item: URL(string: "https://apps.apple.com/us/app/light-speedometer/id6447198696")!) {
                        Image(systemName: "square.and.arrow.up")
                    }
                    
                    LikeButtonView(isLiked: $isLiked)
                }
            }
            .frame(width: 400)
            
            // Map
            ExpandableMapView()
            
        }
        
    }
}

#Preview(windowStyle: .automatic) {
    ArchiveDetailView(artifact: ArtifactsCollection().artifacts.first!)
}
