//
//  Test2.swift
//  Arcy
//
//  Created by Matt Novoselov on 02/05/24.
//

import SwiftUI

struct ArchiveView: View {
    
    // Search text
    @State private var searchText: String = ""
    
    // Currently selected page
    @State private var selectionPage: SelectionPage = .collection
    
    @State private var showingLiked: Bool = false
    
    // Load all artifacts from the collection
    private let artifactCollection: [Artifact] = ArtifactsCollection().artifacts
    
    var body: some View {
        
        NavigationStack{
            // Wrap up in ZStack for animation
            ZStack{
                Group{
                    switch selectionPage{
                    case .recommendation:
                        RecommendationProxyView(artifactCollection: artifactCollection)
                            .transition(.move(edge: .trailing))
                        
                    case .collection:
                        CollectionView(artifactCollection: artifactCollection, searchText: $searchText, showingLiked: $showingLiked)
                            .transition(.move(edge: .leading))
                    }
                }
                .padding(.horizontal)
                .frame(maxWidth: .infinity, maxHeight: .infinity)
            }
            
            // Ornament
            .toolbar{
                // Toolbar that resembles selection picker
                ToolbarItem(placement: .bottomOrnament){
                    HStack{
                        ForEach(SelectionPage.allCases, id: \.self) { category in
                            Button(action: {
                                withAnimation{
                                    self.selectionPage = category
                                }
                            }){
                                Text(category.title)
                            }
                            .background(self.selectionPage == category ? .thinMaterial : .bar, in: .capsule)
                        }
                    }
                }
            }
            
            // Toolbar
            .toolbar{
                // Profile View
                ToolbarItem(placement: .topBarLeading){
                    NavigationLink(destination: ProfileView()){
                        Image(systemName: "circle")
                    }
                    .overlay{
                        ProfilePictureView()
                            .allowsHitTesting(false)
                            .contentShape(.hoverEffect, .circle)
                            .hoverEffect()
                    }
                    .buttonBorderShape(.circle)
                    .help("Profile")
                }
                
                // Favorites View
                ToolbarItem(placement: .topBarTrailing){
                    Toggle(isOn: $showingLiked.animation()){
                        Label("Favorites", systemImage: "heart")
                    }
                    .disabled(selectionPage == .recommendation)
                }
                
                // Guess Game View
                ToolbarItem(placement: .topBarLeading){
                    NavigationLink(destination: GameView()){
                        Label("Game", systemImage: "trophy")
                    }
                }
            }
            
        }
        .searchable(text: $searchText)
        
    }
    
}

// Add tabs for the Archive view
enum SelectionPage: CaseIterable {
    case collection // Represent the view with all available artifacts
    case recommendation // Represent AI powered search
    
    // Text title for tabs
    var title: String {
        switch self {
        case .collection:
            return "Collection"
        case .recommendation:
            return "Recommendation"
        }
    }
}

#Preview(windowStyle: .automatic) {
    ArchiveView()
}
