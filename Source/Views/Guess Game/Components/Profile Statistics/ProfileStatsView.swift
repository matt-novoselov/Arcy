//
//  ProfileStats.swift
//  Arcy
//
//  Created by Matt Novoselov on 08/05/24.
//

import SwiftUI

// Profile statistics view is used to display statistics in the end of the game
// The view indicates user's progress and how well he has performed during the game
struct ProfileStatsView: View {
    
    // Pass an amount of progress that user completed during the game
    @Binding var progress: Double
    
    var body: some View {
        // Display user's profile picture
        ProfilePictureView()
            .padding(.all, 30)
            .overlay{
                // Display circular progress bar around the user's profile picture to indicate user's progress and how well he has performed
                CircularProgressView(progress: $progress)
            }
    }
}

#Preview(windowStyle: .automatic) {
    ProfileStatsView(progress: .constant(0.5))
        .previewVariables()
}
