//
//  ArchiveGridView.swift
//  Arcy
//
//  Created by Matt Novoselov on 04/05/24.
//

import SwiftUI

struct ArchiveGridView: View {
    
    // Adapt to different screen sizes
    // Fill remaining space even if column rows are specified as two
    let columns = [
        GridItem(.adaptive(minimum: 300))
    ]
    
    let itemsCollection: [ArcheologicalItem] = ArcheologicalItemsCollection().items
    
    @Binding var searchText: String
    
    
    var body: some View {
        
        let filteredArchive: [ArcheologicalItem] = filterItems()
        
        if filteredArchive.isEmpty{
            ContentUnavailableView("No results", systemImage: "magnifyingglass", description: Text("Check the spelling or try a new search."))
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
        }
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
    ArchiveGridView(searchText: .constant(""))
}
