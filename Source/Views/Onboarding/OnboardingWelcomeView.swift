//
//  OnboardingWelcomeView.swift
//  Arcy
//
//  Created by Matt Novoselov on 02/05/24.
//

import SwiftUI

// The first view during onboarding phase that user sees after opening the app
struct OnboardingWelcomeView: View {
    
    // Binding for controlling current onboarding scene
    @Binding var onboardingState: onboardingState
    
    var body: some View {
        
        VStack(spacing: 10) {
            // Display app logo in the written form
            Image(.arcyLogoText)
                .interpolation(.high)
                .resizable()
                .scaledToFit()
                .opacity(0.5)
                .frame(height: 20)
            
            Spacer()
            
            // Main title
            Text("Welcome, Explorer")
                .font(.extraLargeTitle)
                .fontWidth(.expanded)
            
            // Sub description
            Text("Dive into the world of archeology")
                .font(.title3)
                .foregroundStyle(.secondary)
            
            Spacer()
            
            // Button to switch onboarding state and navigate to the next View
            Button(action: {switchState()}){
                Text("Continue")
            }
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .padding(.all, 40)
        
    }
    
    // Function to switch onboarding state and navigate to the next View
    func switchState(){
        withAnimation{
            onboardingState = .features
        }
    }
}

#Preview(windowStyle: .automatic) {
    OnboardingWelcomeView(onboardingState: .constant(.welcome))
        .previewVariables()
}
