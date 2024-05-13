//
//  BackgroundGradientView.swift
//  Arcy
//
//  Created by Matt Novoselov on 05/05/24.
//

import SwiftUI

// Animated Gradient is displayed in the background during the onboarding phase
// Note: Not everything (including some Metal shaders) are working in Previews
// Use simulator
struct BackgroundGradientView: View {
    
    // Pass time elapsed since appear of the view
    // The time should be passed from the outside to ensure that it is persistent between different scenes
    let elapsedTime: Double
    
    var body: some View {
        
        // Display animated gradient in the form of the rectangle
        Rectangle()
            .opacity(0.7)
        
            // Apply the visual effect with an animated rainbow line
            .visualEffect { content, proxy in
                content
                    .colorEffect(
                        ShaderLibrary.sinebow(
                            .float2(proxy.size),
                            .float(elapsedTime)
                        )
                    )
            }
        
            // Blur animated line to create visual effect
            .blur(radius: 150.0)
        
    }
}
