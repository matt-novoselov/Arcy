//
//  SecondaryVolumeView.swift
//  Arcy
//
//  Created by Matt Novoselov on 11/05/24.
//

import SwiftUI

struct SecondaryVolumeView: View {
    
    @Environment(VolumeModelView.self) private var volumeModel
    
    var body: some View {
        
        VolumetricModelView(modelName: volumeModel.nameOfModel)

    }
}

#Preview {
    SecondaryVolumeView()
        .environment(VolumeModelView())
}
