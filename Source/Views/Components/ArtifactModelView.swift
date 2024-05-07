//
//  ModelView.swift
//  Arcy
//
//  Created by Matt Novoselov on 03/05/24.
//

import SwiftUI
import RealityKit

struct ArtifactModelView: View {
    
    let modelName: String
    
    // Animate model opacity on appear
    @State private var modelOpacity: Double = 0
    
    var body: some View {
        
        Model3D(named: modelName) { model in
            model
                .resizable()
                .scaledToFit()
                .opacity(modelOpacity)
                .padding()
            
            // Animate model opacity on appear
                .onAppear(){
                    withAnimation(.interpolatingSpring(duration: 1.5)){
                        modelOpacity = 1
                    }
                }
        } placeholder: {
            ProgressView()
                .frame(height: 300)
        }
        .frame(height: 300)
        
    }
}

#Preview(windowStyle: .automatic) {
    ArtifactModelView(modelName: "Attic_red_figured_krater")
}
