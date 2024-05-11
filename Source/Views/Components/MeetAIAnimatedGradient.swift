//
//  GradientBackgroundAnimation.swift
//  SwiftUIAnimations
//
//  Created by Kavinkumar on 14/02/23.
//


import SwiftUI

struct MeetAIAnimatedGradient: View {
    
    @State private var animateGradient: Bool = false
    
    var body: some View {
        
        Group{
            Text("Meet ") +
            Text("AI Recommendations")
                .fontWeight(.black)
                .foregroundStyle(
                    LinearGradient(colors: [.iconPurple, .iconBlue], startPoint: .topLeading, endPoint: .bottomTrailing)
                )
        }
        .font(.largeTitle)
        .hueRotation(.degrees(animateGradient ? 90 : 0))
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
