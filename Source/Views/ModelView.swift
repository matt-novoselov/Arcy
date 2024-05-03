//
//  ModelView.swift
//  Arcy
//
//  Created by Matt Novoselov on 03/05/24.
//

import SwiftUI
import RealityKit
import RealityKitContent

struct ModelView: View {
    
    var modelName: String
    @State private var modelOpacity: Double = 0
    
    var body: some View {
        
        Model3D(named: modelName) { model in
            model
                .resizable()
                .scaledToFit()
                .opacity(modelOpacity)
                .padding()
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
    ModelView(modelName: "Pinax_with_depiction_of_Zeus")
}
