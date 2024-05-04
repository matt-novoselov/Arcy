//
//  FavoritesView.swift
//  Arcy
//
//  Created by Matt Novoselov on 02/05/24.
//

import SwiftUI

struct FavoritesView: View {
    var body: some View {
        
        ContentUnavailableView("No favorites", systemImage: "heart.slash", description: Text("Add favorite artifacts by clicking the like button."))
            .navigationTitle("Favorites artifacts")
        
    }
}

#Preview(windowStyle: .automatic) {
    FavoritesView()
}
