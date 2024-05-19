//
//  ViewModel.swift
//  Arcy
//
//  Created by Matt Novoselov on 11/05/24.
//

import Foundation

// Volume Model is responsible for controlling what Artifact should currently be displayed in the 3D volume
@Observable
class VolumeModelView {
    
    // Name of the 3D model that represents the artifact
    // Note: Pass only the name of the model in the .usdz format without an extension itself
    // Example:
    // If the model in the Resource folder is named MyModel.usdz, you only need to pass MyModel
    var nameOfModel: String = "Small_terracotta_figurine_of_a_veiled_woman"
    
    // Property that controls if the volume with the selected model is Expanded
    var isExpanded: Bool = false
    
}
