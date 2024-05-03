//
//  ItemFlatCardView.swift
//  Arcy
//
//  Created by Matt Novoselov on 03/05/24.
//

import SwiftUI

struct ItemFlatCardView: View {
    
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
                .glassBackgroundEffect()
        }
        .aspectRatio(1, contentMode: .fit)

        
    }
}

#Preview(windowStyle: .automatic) {
    ItemFlatCardView(title: "Lorem ipsum dolor sit", imageName: Image(.placeholder))
}
