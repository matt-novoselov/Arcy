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
    
    // Adapt to different screen sizes
    // Fill remaining space even if column rows are specified as two
    let columns = [
        GridItem(.adaptive(minimum: 300))
    ]
    
    let itemsCollection: [ArcheologicalItem] = ArcheologicalItemsCollection().items
    
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
                
                if showingFiltered{
                    RecommendationView()
                        .frame(maxWidth: .infinity, maxHeight: .infinity)
                        .transition(.move(edge: .trailing))
                } else{
                    ScrollView{
                        LazyVGrid(columns: columns) {
                            ForEach(filterItems()) { selectedItem in
                                
                                NavigationLink(destination: ArchiveDetailView(selectedItem: selectedItem)){
                                    ItemFlatCardView(title: selectedItem.name, imageName: selectedItem.previewImage)
                                }
                                .buttonStyle(BorderlessButtonStyle())
                                .buttonBorderShape(.roundedRectangle)
                                
                            }
                        }
                    }
                    .transition(.move(edge: .leading))
                }

            }
            .padding()
            .toolbar{
                ToolbarItem(placement: .topBarLeading){
                    NavigationLink(destination: ProfileView(settings: settings)){
                        Image(systemName: "heart")
                    }
                    .buttonBorderShape(.circle)
                    .overlay{
                        ProfilePictureView(settings: settings)
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
    
    func filterItems() -> [ArcheologicalItem] {
        let searchTextTrimmed = searchText.trimmingCharacters(in: .whitespacesAndNewlines)
        guard !searchTextTrimmed.isEmpty else {
            return itemsCollection
        }
        
        return itemsCollection.filter { item in
            let searchTextLowercased = searchTextTrimmed.lowercased()
            let itemNameLowercased = item.name.lowercased().replacingOccurrences(of: " ", with: "")
            let itemDescriptionLowercased = item.description.lowercased().replacingOccurrences(of: " ", with: "")
            
            return itemNameLowercased.contains(searchTextLowercased) ||
            itemDescriptionLowercased.contains(searchTextLowercased)
        }
    }
    
}

#Preview(windowStyle: .automatic) {
    ArchiveView(settings: ProfileData(userName: ""))
}
