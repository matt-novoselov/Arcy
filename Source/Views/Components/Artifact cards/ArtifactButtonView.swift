//
//  ArtifactButton.swift
//  Arcy
//
//  Created by Matt Novoselov on 05/05/24.
//

import SwiftUI

// Artifact Button View is a wrapper for ArtifactFlatCardView that enables functionality of tappable button
struct ArtifactButtonView: View {
    
    // Pass the selected artifact
    let selectedArtifact: Artifact
    
    // Define corner radius for all buttons, including views in the child view
    private let buttonCornerRadius: Double = 25
    
    // Property that controls if the like should be displayed or not
    // Likes should be displayed in the collection grid, but not in the recommendations
    var showingLike: Bool = true
    
    var showingAi: Bool = true
    
    var body: some View {
        // Display navigation link that should lead to the Artifact detail view
        NavigationLink(destination: ArtifactDetailView(selectedArtifact: selectedArtifact)){
            ArtifactFlatCardView(selectedArtifact: selectedArtifact, buttonCornerRadius: buttonCornerRadius, showingLike: showingLike, showingAi: showingAi)
        }
        // Adjust button shape
        .buttonStyle(PlainButtonStyle())
        .buttonBorderShape(.roundedRectangle(radius: buttonCornerRadius))
    }
}

#Preview {
    ArtifactButtonView(selectedArtifact: ArtifactsCollection().artifacts.first!)
        .previewVariables()
}
