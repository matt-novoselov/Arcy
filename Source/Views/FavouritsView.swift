//
//  FavoritesView.swift
//  Ancient Archive
//
//  Created by Matt Novoselov on 02/05/24.
//

import SwiftUI

struct FavoritesView: View {
    var body: some View {
        
        ContentUnavailableView("No favorites", systemImage: "heart.slash", description: Text("Add favorite items by clicking like button in archive item's page."))
            .navigationTitle("Favorites Items")
        
    }
}

#Preview(windowStyle: .automatic) {
    FavoritesView()
}
