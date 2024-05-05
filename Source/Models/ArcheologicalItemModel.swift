//
//  ArcheologicalModel.swift
//  Arcy
//
//  Created by Matt Novoselov on 02/05/24.
//

import Foundation
import SwiftUI

struct Artifact: Identifiable {
    var id: UUID = UUID()
    var modelName: String
    var name: String
    var description: String
    var location: (latitude: Double, longitude: Double)
    var previewImage: Image
}
