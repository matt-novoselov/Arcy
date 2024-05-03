//
//  Test2.swift
//  Ancient Archive
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
    
    @State private var searchText = ""
    
    var body: some View {
        
        NavigationStack{
            ScrollView{
                LazyVGrid(columns: columns) {
                    ForEach(filterItems()) { selectedItem in
                        
                        NavigationLink(destination: ArchiveDetailView(selectedItem: selectedItem)){
                            ZStack(alignment: .bottom){
                                selectedItem.previewImage
                                    .resizable()
                                    .scaledToFit()
                                    .padding()
                                
                                Text(selectedItem.name)
                                    .padding()
                                    .glassBackgroundEffect()
                            }
                        }
                        .buttonBorderShape(.roundedRectangle)
                        
                    }
                }
            }
            .padding()
            .toolbar{
                ToolbarItem(placement: .topBarLeading){
                    NavigationLink(destination: ProfileView()){
                        Image(systemName: "person.crop.circle.fill")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                    }
                    .buttonBorderShape(.circle)
                }
                
                ToolbarItem(placement: .topBarLeading){
                    NavigationLink(destination: FavoritesView()){
                        Image(systemName: "heart")
                    }
                    .buttonBorderShape(.circle)
                }
                
                ToolbarItem(placement: .topBarLeading){
                    NavigationLink(destination: RecommendationView()){
                        Image(systemName: "sparkles")
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
    ArchiveView()
}

extension UINavigationBar {
    static func changeAppearance(clear: Bool) {
        let appearance = UINavigationBarAppearance()
        
        if clear {
            appearance.configureWithTransparentBackground()
        } else {
            appearance.configureWithDefaultBackground()
        }
        
        UINavigationBar.appearance().standardAppearance = appearance
        UINavigationBar.appearance().compactAppearance = appearance
        UINavigationBar.appearance().scrollEdgeAppearance = appearance
    }
}
