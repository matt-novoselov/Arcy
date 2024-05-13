//
//  ProfilePictureView.swift
//  Arcy
//
//  Created by Matt Novoselov on 03/05/24.
//

import SwiftUI

// Profile picture View handles and displays the user photo that is stored in the system
// If user doesn't has a photo, it return a placeholder
// View always return a circular photo
struct ProfilePictureView: View {
    
    // Load model for managing photo data and interactions
    @Environment(PhotoViewModel.self)
    private var photoViewModel
    
    // Specify time for shimmer glance to happen
    // Shimmer glance should occur after the user changes the profile photo
    var startTime = Date.now
    
    // Specify if shimmer glance should be visible
    // By default shimmer glance is hidden
    var showingShimmer: Bool = false
    
    var body: some View {
        
        // Wrap profile photo in the Timeline View to manage Metal visual effects and shaders
        TimelineView(.animation) { timeline in
            
            // Calculate time elapsed from startTime value
            // Needed for Metal shaders to work properly
            let elapsedTime = startTime.distance(to: timeline.date)
            
            Group{
                // Load image from persistence
                if let image = photoViewModel.image {
                    // Make sure the image is always circular
                    Circle()
                        .aspectRatio(1, contentMode: .fit)
                        .foregroundStyle(.clear)
                        .overlay{
                            Image(uiImage: image)
                                .interpolation(.high)
                                .resizable()
                                .scaledToFill()
                        }
                } else {
                    // Display placeholder if no profile picture
                    Image(.profilePicturePlaceholder)
                        .interpolation(.high)
                        .resizable()
                }
            }
            .clipShape(.circle)
            .scaledToFit()
            
            // Apply shimmer visual effect
            .visualEffect { content, proxy in
                content
                    .colorEffect(
                        ShaderLibrary.shimmer(
                            .float2(proxy.size), // The size of the entire view, in user-space.
                            .float(elapsedTime), // The number of elapsed seconds since the shader was created.
                            .float(1.5), // The duration of a single loop of the shimmer animation, in seconds.
                            .float(0.5), // The width of the shimmer gradient in UV space.
                            // Display effect only if showingShimmer is enabled
                            .float(showingShimmer ? 0.5 : 0) // The maximum lightness at the peak of the gradient.
                        )
                    )
            }
        }
        
    }
}

#Preview(windowStyle: .automatic) {
    ProfilePictureView(showingShimmer: true)
        .previewVariables()
}
