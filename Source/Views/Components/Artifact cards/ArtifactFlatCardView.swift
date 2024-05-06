//
//  ItemFlatCardView.swift
//  Arcy
//
//  Created by Matt Novoselov on 03/05/24.
//

import SwiftUI

struct ArtifactFlatCardView: View {
    
    let title: String
    let imageName: Image
    let buttonCornerRadius: Double
    
    @State private var isLiked: Bool = false
    
    var body: some View {
        
        ZStack (alignment: .bottom){
            // Display image that represent the artifact
            imageName
                .resizable()
                .padding(.all, 30)
            
            // Display the name of the artifact
            Text(title)
                .font(.body)
                .multilineTextAlignment(.center)
                .padding()
                .frame(maxWidth: .infinity)
                .background(.regularMaterial.secondary, in: .rect(cornerRadius: 20))
        }
        .aspectRatio(1, contentMode: .fit)
        .background(.ultraThinMaterial.opacity(0.3), in: .rect(cornerRadius: buttonCornerRadius))
        
        // Display like button
        .overlay{
            LikeButtonView(isLiked: $isLiked)
                .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topTrailing)
                .buttonStyle(PlainButtonStyle())
                .buttonBorderShape(.circle)
                .padding()
        }
        
    }
}

#Preview(windowStyle: .automatic) {
    ArtifactFlatCardView(title: "Lorem ipsum dolor sit", imageName: Image(.placeholder), buttonCornerRadius: 20)
        .frame(width: 300, height: 300)
}
