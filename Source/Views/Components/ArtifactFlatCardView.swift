//
//  ItemFlatCardView.swift
//  Arcy
//
//  Created by Matt Novoselov on 03/05/24.
//

import SwiftUI

struct ArtifactFlatCardView: View {
    
    var title: String
    var imageName: Image
    
    @State private var isLiked: Bool = false
    
    var body: some View {
        
        ZStack (alignment: .bottom){
            imageName
                .resizable()
                .padding(.all, 30)
                .glassBackgroundEffect()
            
            Text(title)
                .font(.title3)
                .multilineTextAlignment(.center)
                .padding()
                .frame(maxWidth: .infinity)
                .glassBackgroundEffect()
            
            LikeButtonView(isLiked: $isLiked)
                .buttonBorderShape(.circle)
                .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topTrailing)
        }
        .aspectRatio(1, contentMode: .fit)

        
    }
}

#Preview(windowStyle: .automatic) {
    ArtifactFlatCardView(title: "Lorem ipsum dolor sit", imageName: Image(.placeholder))
}
