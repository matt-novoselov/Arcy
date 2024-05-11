//
//  TempGridView.swift
//  Arcy
//
//  Created by Matt Novoselov on 09/05/24.
//

import SwiftUI

struct GridView: View {
    
    // Adapt to different screen sizes
    // Fill remaining space even if column rows are specified as two
    private let columns = [
        GridItem(.adaptive(minimum: 300))
    ]
    
    var gridToDisplay: [Artifact]
    
    var showingLikes: Bool = true
    
    var body: some View {
        ScrollView{
            LazyVGrid(columns: columns) {
                ForEach(gridToDisplay) { artifact in
                    ArtifactButtonView(selectedArtifact: artifact, showingLike: showingLikes)
                        .padding()
                    
                    // Add scroll transition that fades out element on the top
                        .scrollTransition() { content, phase in
                            content
                            // Use phase.value < 0 to apply transition effects only to the top leading of scrollview
                                .opacity(phase.value < 0 ? 0 : 1)
                                .scaleEffect(phase.value < 0 ? 0.8 : 1)
                        }
                        .transition(.scale)
                }
            }
        }
        .padding(.bottom)
    }
}
