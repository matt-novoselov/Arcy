//
//  CubeView.swift
//  Arcy
//
//  Created by Matt Novoselov on 11/05/24.
//

import SwiftUI
import RealityKit

struct VolumetricModelView: View {
    
    @Environment(VolumeModelView.self)
    private var volumeModel
    
    var body: some View {
        
        Model3D(named: volumeModel.nameOfModel) { model in
            switch model {
            case .empty:
                ProgressView()
                
            case .success(let resolvedModel3D):
                resolvedModel3D
                    .resizable()
                    .scaledToFit()
                
            case .failure(let error):
                Text(error.localizedDescription)
                
            @unknown default:
                EmptyView()
            }
        }
        
    }
}

#Preview {
    VolumetricModelView()
        .previewVariables()
}
