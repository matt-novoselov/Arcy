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
                .background(.fill.tertiary, in: .capsule)
        }
        .aspectRatio(1, contentMode: .fit)
        .background(.regularMaterial.quaternary, in: .rect(cornerRadius: 30))
        
    }
}

#Preview(windowStyle: .automatic) {
    ArtifactFlatCardView(title: "Lorem ipsum dolor sit", imageName: Image(.placeholder))
}
