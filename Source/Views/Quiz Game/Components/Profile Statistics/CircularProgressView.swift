//
//  CircleProgressBarView.swift
//  Arcy
//
//  Created by Matt Novoselov on 08/05/24.
//

import SwiftUI

// CircularProgressView indicates user's progress and how well he has performed during the game
struct CircularProgressView: View {
    
    @Binding var progress: Double
    
    // Define the width of the progress bar
    let strokeWidth: Double = 20
    
    // Adjust progress to match the size of the circular progress bar
    // The progress bar is an arc, which is a 75% of a filled circle, so the progress should be adjusted accordingly
    var adjustedProgress: Double{
        progress * 0.75
    }
    
    // Setup a gradient, which is composed from colors of a gradient of an icon
    let myGradient = Gradient(
        colors: [
            Color(.iconPurple),
            Color(.iconBlue)
        ]
    )
    
    var body: some View {
        
        ZStack {
            // Base of the progress bar
            Circle()
                .trim(from: 0, to: 0.75)
                .stroke(
                    .thickMaterial,
                    style: StrokeStyle(
                        lineWidth: strokeWidth,
                        lineCap: .round
                    )
                )
            
            // Animated part of the progress bar
            Circle()
                .trim(from: 0, to: adjustedProgress)
                .stroke(
                    myGradient,
                    style: StrokeStyle(
                        lineWidth: strokeWidth,
                        lineCap: .round
                    )
                )
        }
        
        // Rotate 135 degrees to align progress bar properly
        .rotationEffect(.degrees(135))
        
    }
}

#Preview {
    CircularProgressView(progress: .constant(1))
        .previewVariables()
}
