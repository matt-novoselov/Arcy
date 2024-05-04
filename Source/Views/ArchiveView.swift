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
            
            VStack(spacing: 0) {
                Picker("What is your favorite color?", selection: $showingFiltered.animation()) {
                    Text("Full collection").tag(false)
                    Text("Recommendations").tag(true)
                }
                .pickerStyle(.segmented)
                
                TabView(selection: $showingFiltered) {
                    ArchiveGridView(searchText: $searchText)
                        .tag(false)
                    
                    RecommendationView()
                        .tag(true)
                }
                .tabViewStyle(.page(indexDisplayMode: .never))
                
            }
            .padding(.horizontal)
            .toolbar{
                ToolbarItem(placement: .topBarLeading){
                    NavigationLink(destination: ProfileView()){
                        Button(action: {}){
                            Image(systemName: "circle")
                        }
                        .buttonBorderShape(.circle)
                        .foregroundStyle(.clear)
                        .overlay{
                            ProfilePictureView()
                        }
                    }
                    .buttonStyle(PlainButtonStyle())
                }
                
                ToolbarItem(placement: .topBarLeading){
                    NavigationLink(destination: FavoritesView()){
                        Image(systemName: "heart")
                    }
                    .buttonBorderShape(.circle)
                }
                
                ToolbarItem(placement: .topBarLeading){
                    NavigationLink(destination: ShadowGuessView()){
                        Image(systemName: "trophy")
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
