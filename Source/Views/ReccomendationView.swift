//
//  RecommendationView.swift
//  Arcy
//
//  Created by Matt Novoselov on 03/05/24.
//

import SwiftUI

struct RecommendationView: View {
    var body: some View {
        
        ContentUnavailableView("No recommendations", systemImage: "sparkle.magnifyingglass", description: Text("Try adding a few favorite items to see recommendations"))
        
    }
}

#Preview(windowStyle: .automatic) {
    RecommendationView()
}
