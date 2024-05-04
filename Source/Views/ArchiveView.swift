//
//  Test2.swift
//  Arcy
//
//  Created by Matt Novoselov on 02/05/24.
//

import SwiftUI

struct ArchiveView: View {
    
    @State private var searchText: String = ""
    @State private var showingFiltered: Bool = false
    
    var body: some View {
        
        NavigationStack{
            Group{
                switch showingFiltered{
                case true:
                    RecommendationView()
                        .transition(.move(edge: .leading))
                    
                case false:
                    ArchiveGridView(searchText: $searchText)
                        .transition(.move(edge: .trailing))
                }
            }
            .padding(.horizontal)
            
            .toolbar{
                ToolbarItem(placement: .bottomOrnament){
                    Picker("What is your favorite color?", selection: $showingFiltered.animation()) {
                        Text("Collection").tag(false)
                        Text("Recommendations").tag(true)
                    }
                    .pickerStyle(.segmented)
                }
            }
            
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
