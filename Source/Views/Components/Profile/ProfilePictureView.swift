//
//  ProfilePictureView.swift
//  Arcy
//
//  Created by Matt Novoselov on 03/05/24.
//

import SwiftUI

struct ProfilePictureView: View {
    
    // Specify time for shimmer glance to happen
    var startTime = Date.now
    
    // Specify if shimmer glance should be visible
    var showingShimmer: Bool = false
    
    var body: some View {
        
        TimelineView(.animation) { timeline in
            let elapsedTime = startTime.distance(to: timeline.date)
            
            Group{
                // MARK: Load image from persistence
                Image(.profilePicturePlaceholder)
                    .interpolation(.high)
                    .resizable()
            }
            .clipShape(.circle)
            .scaledToFit()
            
            // Add shimmer visual effect
            .visualEffect { content, proxy in
                content
                    .colorEffect(
                        ShaderLibrary.shimmer(
                            .float2(proxy.size),
                            .float(elapsedTime),
                            .float(1.5),
                            .float(0.5),
                            // Display effect only if showingShimmer is enabled
                            .float(showingShimmer ? 0.5 : 0)
                        )
                    )
            }
        }
        
    }
}

#Preview(windowStyle: .automatic) {
    ProfilePictureView(showingShimmer: true)
}
