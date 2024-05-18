//
//  SelectionPageView.swift
//  Arcy
//
//  Created by Matt Novoselov on 02/05/24.
//

import SwiftUI

struct SelectionPageView: View {
    
    // Currently selected page
    @State private var selectionPage: SelectionPage = .collection
    
    // Property that controls if only liked Artifacts should be shown
    @State private var showingLiked: Bool = false
    
    // Load all artifacts from the collection
    private let artifactCollection: [Artifact] = ArtifactsCollection().artifacts
    
    var body: some View {
        
        NavigationStack{
            // Display Recommendations or Collection view based on the state of view picker
            // Wrap up in ZStack for animation
            ZStack{
                Group{
                    switch selectionPage{
                    case .recommendation:
                        RecommendationProxyView(artifactCollection: artifactCollection)
                            .transition(.move(edge: .trailing))
                        
                    case .collection:
                        CollectionView(artifactCollection: artifactCollection, showingLiked: $showingLiked)
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
                            .hidden()
                        
                        Text("Profile")
                            .foregroundStyle(.secondary)
                    }
                    .overlay{
                        ProfilePictureView()
                            .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .leading)
                            .padding(.all, 5)
                            .allowsHitTesting(false)
                    }
                }
                
                // Guess Game View
                ToolbarItem(placement: .topBarLeading){
                    NavigationLink(destination: GameView()){
                        HStack{
                            Image(systemName: "graduationcap")
                            
                            Text("Take quiz")
                                .foregroundStyle(.secondary)
                        }
                    }
                }
                
                // Favorites View
                if selectionPage == .collection{
                    ToolbarItem(placement: .topBarTrailing){
                        Toggle(isOn: $showingLiked.animation()){
                            Label("Favorites", systemImage: showingLiked ? "heart.fill" : "heart")
                        }
                    }
                }

            }
            
        }
        
    }
    
}

// Add tabs for the Selection Page view
enum SelectionPage: CaseIterable {
    case collection // Represent the view with all available artifacts
    case recommendation // Represent AI powered search
    
    // Text title for tabs
    var title: String {
        switch self {
        case .collection:
            return "Collection"
        case .recommendation:
            return "Recommendations"
        }
    }
}

#Preview(windowStyle: .automatic) {
    SelectionPageView()
        .previewVariables()
}
