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
    
    let buttonCornerRadius: Double
    @State var isLiked: Bool = false
    
    var body: some View {
        
        ZStack (alignment: .bottom){
            imageName
                .resizable()
                .padding(.all, 30)
            
            Text(title)
                .font(.headline)
                .multilineTextAlignment(.center)
                .padding()
                .frame(maxWidth: .infinity)
                .background(.regularMaterial.secondary, in: .rect(cornerRadius: 20))
        }
        .aspectRatio(1, contentMode: .fit)
        .background(.ultraThinMaterial.opacity(0.3), in: .rect(cornerRadius: buttonCornerRadius))
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
