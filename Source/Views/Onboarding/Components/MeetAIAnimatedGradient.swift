//
//  MeetAIAnimatedGradient.swift
//  Arcy
//
//  Created by Matt Novoselov on 10/05/24.
//


import SwiftUI

// Gradient animated text for onboarding section
struct MeetAIAnimatedGradient: View {
    
    // Property that is used to control the state of gradient animation
    @State private var animateGradient: Bool = false
    
    var body: some View {
        
        Group{
            // Normal text
            Text("Meet ") +
            // Gradient text
            Text("AI Recommendations")
                .fontWeight(.black)
                .foregroundStyle(
                    // Use branding logo colors for default gradient
                    LinearGradient(colors: [.iconPurple, .iconBlue], startPoint: .topLeading, endPoint: .bottomTrailing)
                )
        }
        .font(.largeTitle)
        
        // Apply gradient animation with hue rotation
        .hueRotation(.degrees(animateGradient ? 90 : 0))
        
        // Start infinite animation on bootstrap
        .onAppear {
            withAnimation(.easeInOut(duration: 3).repeatForever(autoreverses: true)) {
                animateGradient.toggle()
            }
        }
        
    }
}

#Preview {
    MeetAIAnimatedGradient()
        .previewVariables()
}
