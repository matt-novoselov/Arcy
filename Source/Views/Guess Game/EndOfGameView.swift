//
//  EndOfGameView.swift
//  Arcy
//
//  Created by Matt Novoselov on 06/05/24.
//

import SwiftUI
import RealityKit
import RealityKitContent

struct EndOfGameView: View {
    
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        
        VStack{
            Text("Hello, World!")
                .font(.title)
            
            Spacer()
            
            Button("Back to collection", systemImage: "chevron.left", action: {dismiss()})
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .padding()
        
        // Display confetti on correct answer
        .overlay{
            Model3D(named: "Fireworks", bundle: realityKitContentBundle)
        }

    }
}

#Preview(windowStyle: .automatic) {
    EndOfGameView()
}
