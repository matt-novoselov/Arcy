//
//  ArcheologicalModel.swift
//  Arcy
//
//  Created by Matt Novoselov on 02/05/24.
//

import Foundation
import SwiftUI
import SwiftData

struct Artifact: Identifiable {
    var id: UUID = UUID()
    var artifactID: Int
    var modelName: String
    var name: String
    var description: String
    var location: (latitude: Double, longitude: Double)
    var previewImage: Image
}
