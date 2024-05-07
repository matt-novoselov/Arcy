//
//  ItemFlatCardView.swift
//  Arcy
//
//  Created by Matt Novoselov on 03/05/24.
//

import SwiftUI

struct ArtifactFlatCardView: View {
    
    let selectedArtifact: Artifact
    let buttonCornerRadius: Double
    
    @State private var isLiked: Bool = false
    
    var body: some View {
        
        ZStack (alignment: .bottom){
            // Display image that represent the artifact
            Rectangle()
                .foregroundStyle(.clear)
                .scaledToFit()
                .aspectRatio(1, contentMode: .fit)
                .overlay{
                    Image(selectedArtifact.previewImage)
                        .interpolation(.high)
                        .resizable()
                        .scaledToFit()
                        .padding(.all, 30)
                }
            
            // Display the name of the artifact
            Text(selectedArtifact.name)
                .font(.body)
                .fontWeight(.bold)
                .multilineTextAlignment(.center)
                .padding()
                .frame(maxWidth: .infinity)
                .background(.regularMaterial, in: .rect(cornerRadius: buttonCornerRadius-10))
                .padding()
        }
        .aspectRatio(1, contentMode: .fit)
        .background(.ultraThinMaterial.opacity(0.3), in: .rect(cornerRadius: buttonCornerRadius))
        
        // Display like button
        .overlay{
            LikeButtonView(artifactID: selectedArtifact.artifactID)
                .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topTrailing)
                .buttonStyle(PlainButtonStyle())
                .buttonBorderShape(.circle)
                .padding()
        }
        
    }
}

#Preview(windowStyle: .automatic) {
    ArtifactFlatCardView(selectedArtifact: ArtifactsCollection().artifacts.first!, buttonCornerRadius: 20)
        .frame(width: 300, height: 300)
}
