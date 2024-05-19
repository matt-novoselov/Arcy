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
    
    // Property that animates the blur radius that is applied to the text
    @State private var blurRadius: Double = 10
    
    // Animated property that hides visibility of button, until blur animation is finished
    @State private var buttonVisible: Bool = false
    
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
            
            Group{
                // Main title
                Text("Welcome, Explorer")
                    .font(.extraLargeTitle)
                    .fontWeight(.black)
                
                // Sub description
                Text("Dive into the world of archeology like never before")
                    .font(.title3)
                    .foregroundStyle(.secondary)
            }
            .blur(radius: blurRadius)
            
            // Play blur animation on appear
            .onAppear{
                withAnimation(.spring(duration: 3)){
                    blurRadius = 0
                } completion: {
                    withAnimation{
                        buttonVisible = true
                    }
                }
            }
            
            Spacer()
            
            // Button to switch onboarding state and navigate to the next View
            if buttonVisible{
                Button(action: {switchState()}){
                    Text("Continue")
                }
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
