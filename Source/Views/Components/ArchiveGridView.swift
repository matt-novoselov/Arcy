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
    
    let artifactCollection: [Artifact] = Collection().artifacts
    
    @Binding var searchText: String
    
    @State var isLiked: Bool = false
    
    
    var body: some View {
        
        let filteredArchive: [Artifact] = filterArtifacts()
        
        if filteredArchive.isEmpty{
            ContentUnavailableView("No results for \(searchText)", systemImage: "magnifyingglass", description: Text("Check the spelling or try a new search."))
        } else{
            ScrollView{
                LazyVGrid(columns: columns) {
                    ForEach(filterArtifacts()) { artifact in
                        
                        NavigationLink(destination: ArchiveDetailView(artifact: artifact)){
                            ArtifactFlatCardView(title: artifact.name, imageName: artifact.previewImage)
                        }
                        .buttonStyle(PlainButtonStyle())
                        .buttonBorderShape(.roundedRectangle)
                        .overlay{
                            LikeButtonView(isLiked: $isLiked)
                                .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topTrailing)
                                .buttonBorderShape(.circle)
                        }
                        .scrollTransition() { content, phase in
                            content
                            // Use phase.value < 0 to apply transition effects only to the top leading of scrollview
                                .opacity(phase.value < 0 ? 0 : 1)
                                .scaleEffect(phase.value < 0 ? 0.85 : 1)
                        }
                        .padding()
                        
                    }
                }
            }
        }
    }
    
    func filterArtifacts() -> [Artifact] {
        let searchTextTrimmed = searchText.trimmingCharacters(in: .whitespacesAndNewlines)
        guard !searchTextTrimmed.isEmpty else {
            return artifactCollection
        }
        
        return artifactCollection.filter { artifact in
            let searchTextLowercased = searchTextTrimmed.lowercased()
            let artifactNameLowercased = artifact.name.lowercased().replacingOccurrences(of: " ", with: "")
            let artifactDescriptionLowercased = artifact.description.lowercased().replacingOccurrences(of: " ", with: "")
            
            return artifactNameLowercased.contains(searchTextLowercased) ||
            artifactDescriptionLowercased.contains(searchTextLowercased)
        }
    }
    
}

#Preview(windowStyle: .automatic) {
    ArchiveGridView(searchText: .constant(""))
}
