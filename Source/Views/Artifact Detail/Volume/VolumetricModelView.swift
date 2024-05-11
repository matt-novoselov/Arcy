//
//  CubeView.swift
//  Arcy
//
//  Created by Matt Novoselov on 11/05/24.
//

import SwiftUI
import RealityKit

struct VolumetricModelView: View {
        
    let modelName: String
    
    @State private var angle: Angle = .degrees(0)
    
    var body: some View {
        
        Model3D(named: modelName) { model in
            switch model {
            case .empty:
                ProgressView()
                
            case .success(let resolvedModel3D):
                resolvedModel3D
                    .resizable()
                    .scaledToFit()
                    .rotation3DEffect(angle, axis: .y)
                    .animation(.linear(duration: 18).repeatForever(), value: angle)
                    .onAppear {
                        angle = .degrees(359)
                    }
                
            case .failure(let error):
                Text(error.localizedDescription)
                
            @unknown default:
                EmptyView()
            }
        }
        
    }
}

#Preview {
    VolumetricModelView(modelName: "Female_terracotta_head_from_an_etruscan_tomb")
        .previewVariables()
}
