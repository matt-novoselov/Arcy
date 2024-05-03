//
//  Test2.swift
//  Arcy
//
//  Created by Matt Novoselov on 02/05/24.
//

import SwiftUI
import RealityKit
import RealityKitContent

struct ArchiveView: View {
    
    var settings: ProfileData
    
    @State private var searchText: String = ""
    
    @State private var showingFiltered: Bool = false
    
    var body: some View {
        
        NavigationStack{
            
            VStack {
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
                    NavigationLink(destination: ProfileView(settings: settings)){
                        Image(systemName: "heart")
                    }
                    .buttonBorderShape(.circle)
                    .overlay{
                        ProfilePictureView()
                            .allowsHitTesting(false)
                    }
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
    ArchiveView(settings: ProfileData(userName: ""))
}
