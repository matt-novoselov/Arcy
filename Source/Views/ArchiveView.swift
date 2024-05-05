//
//  Test2.swift
//  Arcy
//
//  Created by Matt Novoselov on 02/05/24.
//

import SwiftUI

enum SelectionPage: CaseIterable {
    case collection
    case recommendation
    
    // Text title for Smart Search
    var title: String {
        switch self {
        case .collection:
            return "Collection"
        case .recommendation:
            return "Recommendation"
        }
    }
}

struct ArchiveView: View {
    
    @State private var searchText: String = ""
    @State var selectionPage: SelectionPage = .collection
    
    var body: some View {
        
        NavigationStack{
            ZStack{
                Group{
                    switch selectionPage{
                    case .recommendation:
                        RecommendationView()
                            .transition(.move(edge: .trailing))
                        
                    case .collection:
                        ArchiveGridView(searchText: $searchText)
                            .transition(.move(edge: .leading))
                    }
                }
                .padding(.horizontal)
                .frame(maxWidth: .infinity, maxHeight: .infinity)
            }
            
            // Ornament
            .toolbar{
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
                
                ToolbarItem(placement: .topBarLeading){
                    NavigationLink(destination: FavoritesView()){
                        Label("Favorites", systemImage: "heart")
                    }
                    .buttonBorderShape(.circle)
                }
                
                ToolbarItem(placement: .topBarLeading){
                    NavigationLink(destination: ShadowGuessView()){
                        Label("Game", systemImage: "trophy")
                    }
                    .buttonBorderShape(.circle)
                }
            }
            
        }
        .searchable(text: $searchText)
        
    }
    
}

#Preview(windowStyle: .automatic) {
    ArchiveView()
}
