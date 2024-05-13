//
//  ArchiveGridView.swift
//  Arcy
//
//  Created by Matt Novoselov on 04/05/24.
//

import SwiftUI
import SwiftData

// Collection view displays a grid of all available artifacts
// Users can filter artifacts by toggling "Showing only liked" or/and by using search
struct CollectionView: View {
    
    // Load all artifacts from the collection
    let artifactCollection: [Artifact]
    
    // Search text
    @State private var searchText: String = ""
    
    // Property that controls if only liked Artifacts should be shown
    @Binding var showingLiked: Bool
    
    // Extract information about Artifacts that are already liked from the Swift Data
    @Query private var storedLikedArtifacts: [LikeModel]
    
    var body: some View {
        
        // Array that stores a filtered list of artifacts if filters (search text or showing only liked) are applied
        let filteredCollection: [Artifact] = filterArtifacts()
        
        ZStack{
            // If search results return nil
            if filteredCollection.isEmpty && !searchText.isEmpty {
                ContentUnavailableView("No results for \(searchText)", systemImage: "magnifyingglass", description: Text("Check the spelling or try a new search."))
            } 
            // If user doesn't has any liked artifacts
            else if filteredCollection.isEmpty && showingLiked {
                ContentUnavailableView("No favorites", systemImage: "heart.slash", description: Text("Add favorite artifacts by clicking the like button."))
            } 
            // Display full collection
            else{
                GridView(gridToDisplay: filterArtifacts())
            }
        }
        .searchable(text: $searchText)

    }   
    
    // Function to filter artifacts collection based on user search and/or if users toggle "Showing only liked"
    func filterArtifacts() -> [Artifact] {
        
        // Trim and remove white spaces in the search text
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
    CollectionView(artifactCollection: ArtifactsCollection().artifacts, showingLiked: .constant(false))
        .previewVariables()
}
