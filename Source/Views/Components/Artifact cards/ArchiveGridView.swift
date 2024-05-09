//
//  ArchiveGridView.swift
//  Arcy
//
//  Created by Matt Novoselov on 04/05/24.
//

import SwiftUI
import SwiftData

struct ArchiveGridView: View {
    
    // Adapt to different screen sizes
    // Fill remaining space even if column rows are specified as two
    private let columns = [
        GridItem(.adaptive(minimum: 300))
    ]
    
    // Load all artifacts from the collection
    private let artifactCollection: [Artifact] = ArtifactsCollection().artifacts
    
    // Binding for text that user inputs to the search bar
    @Binding var searchText: String
    
    @Binding var showingLiked: Bool
    
    @Query private var items: [LikeModel]
    
    var body: some View {
        
        let filteredArchive: [Artifact] = filterArtifacts()
        
        if filteredArchive.isEmpty && !searchText.isEmpty {
            ContentUnavailableView("No results for \(searchText)", systemImage: "magnifyingglass", description: Text("Check the spelling or try a new search."))
        } else if filteredArchive.isEmpty && showingLiked {
            ContentUnavailableView("No favorites", systemImage: "heart.slash", description: Text("Add favorite artifacts by clicking the like button."))
        } else{
            ScrollView{
                LazyVGrid(columns: columns) {
                    ForEach(filterArtifacts()) { artifact in
                        ArtifactButtonView(selectedArtifact: artifact)
                            .padding()
                        
                        // Add scroll transition that fades out element on the top
                            .scrollTransition() { content, phase in
                                content
                                // Use phase.value < 0 to apply transition effects only to the top leading of scrollview
                                    .opacity(phase.value < 0 ? 0 : 1)
                                    .scaleEffect(phase.value < 0 ? 0.8 : 1)
                            }
                    }
                }
            }
            .padding(.bottom)
        }
    }
    
//    // Function to filter search of artifacts based on their names or descriptions
//    func filterArtifacts() -> [Artifact] {
//        let searchTextTrimmed = searchText.trimmingCharacters(in: .whitespacesAndNewlines)
//        guard !searchTextTrimmed.isEmpty else {
//            return artifactCollection // if showingLiked == true, then return only liked artifacts out of artifactCollection
//        }
//        
//        return artifactCollection.filter { artifact in
//            let searchTextLowercased = searchTextTrimmed.lowercased()
//            let artifactNameLowercased = artifact.name.lowercased().replacingOccurrences(of: " ", with: "")
//            
//            return artifactNameLowercased.contains(searchTextLowercased) // if showingLiked == true, then return only if the artifact is liked
//        }
//    }
    
    func filterArtifacts() -> [Artifact] {
        let searchTextTrimmed = searchText.trimmingCharacters(in: .whitespacesAndNewlines)
        
        // If the search text is empty and showingLiked is true, return all liked artifacts
        if searchTextTrimmed.isEmpty && showingLiked {
            let likedArtifactIDs = items.filter { $0.isLiked }.map { $0.artifactID }
            return artifactCollection.filter { likedArtifactIDs.contains($0.artifactID) }
        }
        
        // If the search text is empty and showingLiked is false, return all artifacts
        guard !searchTextTrimmed.isEmpty || showingLiked else {
            return artifactCollection
        }
        
        return artifactCollection.filter { artifact in
            // Check if the artifact matches the search text (if provided) and if it's liked (if showingLiked is true)
            let searchTextLowercased = searchTextTrimmed.lowercased()
            let artifactNameLowercased = artifact.name.lowercased().replacingOccurrences(of: " ", with: "")
            
            let nameMatches = artifactNameLowercased.contains(searchTextLowercased)
            
            // If showingLiked is true, also check if the artifact is liked
            if showingLiked {
                // Check if there is a LikeModel for this artifactID that indicates it's liked
                let isLiked = items.contains { likeModel in
                    likeModel.artifactID == artifact.artifactID && likeModel.isLiked
                }
                
                return nameMatches && isLiked
            } else {
                return nameMatches
            }
        }
    }
    
}

#Preview(windowStyle: .automatic) {
    ArchiveGridView(searchText: .constant(""), showingLiked: .constant(false))
        .modelContainer(for: LikeModel.self)
}
