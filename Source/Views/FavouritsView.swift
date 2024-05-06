//
//  FavoritesView.swift
//  Arcy
//
//  Created by Matt Novoselov on 02/05/24.
//

import SwiftUI

struct FavoritesView: View {
    var body: some View {

        ZStack{
            // Display ContentUnavailableView if there are no favorite artifacts
            ContentUnavailableView("No favorites", systemImage: "heart.slash", description: Text("Add favorite artifacts by clicking the like button."))
                .navigationTitle("Favorites artifacts")
        }
        
    }
}

#Preview(windowStyle: .automatic) {
    FavoritesView()
}
