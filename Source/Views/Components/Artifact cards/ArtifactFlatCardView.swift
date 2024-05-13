//
//  ItemFlatCardView.swift
//  Arcy
//
//  Created by Matt Novoselov on 03/05/24.
//

import SwiftUI

// Artifact Flat Card is used to display preview information about an Artifact before entering the Detail View
struct ArtifactFlatCardView: View {
    
    // Pass the selected Artifact to get information from
    let selectedArtifact: Artifact
    
    // Pass the corner radius for the button
    let buttonCornerRadius: Double
    
    // Property that controls if the like should be displayed or not
    // Likes should be displayed in the collection grid, but not in the recommendations
    var showingLike: Bool = true
    
    var body: some View {
        
        ZStack (alignment: .bottom){
            // Display image that represent the artifact in the form of square
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
            
            // Display the name of the artifact with darken background
            Text(selectedArtifact.name)
                .fontWeight(.bold)
                .multilineTextAlignment(.center)
                .frame(maxWidth: .infinity)
                .padding()
                .background(.regularMaterial, in: .rect(cornerRadius: buttonCornerRadius-10))
                .padding(.all, 10)
        }
        .aspectRatio(1, contentMode: .fit)
        .background(.ultraThinMaterial.opacity(0.3), in: .rect(cornerRadius: buttonCornerRadius))
        
        // Display like button
        .overlay{
            if showingLike{
                LikeButtonView(artifactID: selectedArtifact.artifactID)
                    .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topTrailing)
                    .buttonStyle(PlainButtonStyle())
                    .buttonBorderShape(.circle)
                    .padding()
            }
        }
        
    }
}

#Preview(windowStyle: .automatic) {
    ArtifactFlatCardView(selectedArtifact: ArtifactsCollection().artifacts.first!, buttonCornerRadius: 20)
        .frame(width: 300, height: 300)
        .previewVariables()
}
