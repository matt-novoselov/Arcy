//
//  RecommendationView.swift
//  Arcy
//
//  Created by Matt Novoselov on 03/05/24.
//

import SwiftUI

struct RecommendationView: View {
    var body: some View {
        
        VStack{
//            Text("AI can recommend you archeological items by analyzing your favorite items.")
            
            ContentUnavailableView("No recommendations", systemImage: "sparkle.magnifyingglass", description: Text("Try adding a few favorite items to see recommendations"))
        }
        .navigationTitle("Recommended Items")
        
    }
}

#Preview(windowStyle: .automatic) {
    RecommendationView()
}
