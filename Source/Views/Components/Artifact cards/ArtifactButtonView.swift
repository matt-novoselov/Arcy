//
//  ArtifactButton.swift
//  Arcy
//
//  Created by Matt Novoselov on 05/05/24.
//

import SwiftUI

struct ArtifactButtonView: View {
    
    // Pass the selected artifact
    let artifact: Artifact
    
    // Define corner radius for all buttons
    private let buttonCornerRadius: Double = 25
    
    var body: some View {
        NavigationLink(destination: ArchiveDetailView(artifact: artifact)){
            ArtifactFlatCardView(title: artifact.name, imageName: artifact.previewImage, buttonCornerRadius: buttonCornerRadius)
        }
        .buttonStyle(PlainButtonStyle())
        .buttonBorderShape(.roundedRectangle(radius: buttonCornerRadius))
    }
}

#Preview {
    ArtifactButtonView(artifact: ArtifactsCollection().artifacts.first!)
}
