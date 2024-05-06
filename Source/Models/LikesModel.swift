//
//  LikesModel.swift
//  Arcy
//
//  Created by Matt Novoselov on 06/05/24.
//

import Foundation
import SwiftData

@Model
class LikeModel: Identifiable{
    
    var id: UUID
    var artifactID: Int
    var isLiked: Bool
    
    init(artifactID: Int, isLiked: Bool) {
        self.id = UUID()
        self.artifactID = artifactID
        self.isLiked = isLiked
    }
}
