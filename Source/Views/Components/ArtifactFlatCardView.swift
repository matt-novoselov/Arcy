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
    
    var body: some View {
        
        ZStack (alignment: .bottom){
            imageName
                .resizable()
                .padding(.all, 30)
            
            Text(title)
                .font(.title3)
                .multilineTextAlignment(.center)
                .padding()
                .frame(maxWidth: .infinity)
//                .glassBackgroundEffect()
                .background(.regularMaterial.quaternary, in: .capsule)
        }
        .aspectRatio(1, contentMode: .fit)
//        .background(.fill.tertiary, in: .rect(cornerRadius: 20))
        
    }
}

#Preview(windowStyle: .automatic) {
    ArtifactFlatCardView(title: "Lorem ipsum dolor sit", imageName: Image(.placeholder))
}
