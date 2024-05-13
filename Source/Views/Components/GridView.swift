//
//  TempGridView.swift
//  Arcy
//
//  Created by Matt Novoselov on 09/05/24.
//

import SwiftUI

// Grid view is a flexible and dynamic adaptable view that can display multiple Artifact cards based on the Artifacts passed to the grid
// Grid view is used to display all artifacts in the collection, to display favorite artifacts and recommendations
struct GridView: View {
    
    // Adapt to different screen sizes
    // Fill remaining space even if column rows are specified as two
    private let columns = [
        GridItem(.adaptive(minimum: 300))
    ]
    
    // Pass the grid to be displayed
    // Grid can be dynamic and is capable of displaying
    var gridToDisplay: [Artifact]
    
    // Property that controls if the like should be displayed or not
    // Likes should be displayed in the collection grid, but not in the recommendations
    var showingLikes: Bool = true
    
    var body: some View {
        
        // Make view scrollable
        ScrollView{
            // Define lazy grid
            LazyVGrid(columns: columns) {
                // Display each artifact
                ForEach(gridToDisplay) { artifact in
                    // Display Artifact Button
                    ArtifactButtonView(selectedArtifact: artifact, showingLike: showingLikes)
                        .padding()
                    
                        // Add scroll transition that fades out element on the top
                        .scrollTransition() { content, phase in
                            content
                            // Use phase.value < 0 to apply transition effects only to the top leading of scrollview
                                .opacity(phase.value < 0 ? 0 : 1)
                                .scaleEffect(phase.value < 0 ? 0.8 : 1)
                        }
                        
                        // Add scale in out animation for appearing / disappearing of the element
                        // Used for unliking animation and for search
                        .transition(.scale)
                }
            }
            .padding(.bottom)
        }
        // Add animation for changing the layout of the grid
        .animation(.easeInOut, value: gridToDisplay.count)
        
    }
}

#Preview(windowStyle: .automatic){
    GridView(gridToDisplay: ArtifactsCollection().artifacts, showingLikes: true)
}
