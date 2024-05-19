//
//  ArtifactRecommendationModel.swift
//  Arcy
//
//  Created by Matt Novoselov on 19/05/24.
//

import Foundation

// Structure that can represent Model for Artifacts that are being recommended by ML Model in Recommendations View
struct ArtifactRecommendation: Identifiable {
    public var id = UUID()
    public var ArtifactId: Int
    public var isLiked: Double
    // isLiked = 0.0 = false
    // isLiked = 1.0 = true
    // Double representation is in need for ML Model to process recommendations
}
