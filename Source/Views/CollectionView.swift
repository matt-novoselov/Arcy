//
//  ArchiveGridView.swift
//  Arcy
//
//  Created by Matt Novoselov on 04/05/24.
//

import SwiftUI
import SwiftData

struct CollectionView: View {
    
    // Load all artifacts from the collection
    let artifactCollection: [Artifact]
    
    // Binding for text that user inputs to the search bar
    @Binding var searchText: String
    
    @Binding var showingLiked: Bool
    
    @Query private var storedLikedArtifacts: [LikeModel]
    
    var body: some View {
        
        let filteredArchive: [Artifact] = filterArtifacts()
        
        ZStack{
            if filteredArchive.isEmpty && !searchText.isEmpty {
                ContentUnavailableView("No results for \(searchText)", systemImage: "magnifyingglass", description: Text("Check the spelling or try a new search."))
            } else if filteredArchive.isEmpty && showingLiked {
                ContentUnavailableView("No favorites", systemImage: "heart.slash", description: Text("Add favorite artifacts by clicking the like button."))
            } else{
                GridView(gridToDisplay: filterArtifacts())
            }
        }

    }   
    
    func filterArtifacts() -> [Artifact] {
        let searchTextTrimmed = searchText.trimmingCharacters(in: .whitespacesAndNewlines)
        
        // If the search text is empty and showingLiked is true, return all liked artifacts
        if searchTextTrimmed.isEmpty && showingLiked {
            let likedArtifactIDs = storedLikedArtifacts.filter { $0.isLiked }.map { $0.artifactID }
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
                let isLiked = storedLikedArtifacts.contains { likeModel in
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
    CollectionView(artifactCollection: ArtifactsCollection().artifacts, searchText: .constant(""), showingLiked: .constant(false))
        .modelContainer(for: LikeModel.self)
}
