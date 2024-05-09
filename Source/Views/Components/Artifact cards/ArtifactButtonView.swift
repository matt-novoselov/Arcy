//
//  ArtifactButton.swift
//  Arcy
//
//  Created by Matt Novoselov on 05/05/24.
//

import SwiftUI

struct ArtifactButtonView: View {
    
    // Pass the selected artifact
    let selectedArtifact: Artifact
    
    // Define corner radius for all buttons
    private let buttonCornerRadius: Double = 25
    
    var showingLike: Bool = true
    
    var body: some View {
        NavigationLink(destination: ArchiveDetailView(selectedArtifact: selectedArtifact)){
            ArtifactFlatCardView(selectedArtifact: selectedArtifact, buttonCornerRadius: buttonCornerRadius, showingLike: showingLike)
        }
        .buttonStyle(PlainButtonStyle())
        .buttonBorderShape(.roundedRectangle(radius: buttonCornerRadius))
    }
}

#Preview {
    ArtifactButtonView(selectedArtifact: ArtifactsCollection().artifacts.first!)
}
