//
//  OnboardingFeaturesView.swift
//  Arcy
//
//  Created by Matt Novoselov on 03/05/24.
//

import SwiftUI

// Onboarding view that tells user about all of the features presented inside of the app
struct OnboardingFeaturesView: View {
    
    // Binding for controlling current onboarding scene
    @Binding var onboardingState: onboardingState
    
    // Animate appearance of the tutorial elements
    @State var animationPhase: Int = 1
    
    var body: some View {
        VStack(spacing: 20){
            // Main title
            Text("Features")
                .font(.extraLargeTitle)
                .padding()
            
            Spacer()
            
            // Display several onboarding cards with features description
            // Each card appearance is animated
            Group{
                if animationPhase>=1{
                    OnboardingCardView(iconName: "rotate.3d", title: "Intractable Artifacts", description: "Explore artifacts from every angle.")
                }
                
                if animationPhase>=2{
                    OnboardingCardView(iconName: "sparkles", title: "AI Recommendations", description: "Personalized recommendations powered by AI.")
                }
                
                if animationPhase>=3{
                    OnboardingCardView(iconName: "graduationcap", title: "Take a Quiz", description: "Test your knowledge and earn points!")
                }
            }
            .frame(maxWidth: 420)
            
            // Offset cards a bit to the front to create a 3D effect
            .offset(z: 5)
            
            Spacer()
            
            if animationPhase>=4{
                // Button to switch onboarding state and navigate to the next View
                Button(action: {switchState()}){
                    Text("Continue")
                }
            }
        }
        .padding(.all, 40)
        
        // Play phase animation for tutorial elements gradual appearance
        .onAppear {
            Timer.scheduledTimer(withTimeInterval: 1.5, repeats: true) { timer in
                if animationPhase < 4 {
                    withAnimation(.spring) {
                        animationPhase += 1
                    }
                } else {
                    timer.invalidate()
                }
            }
        }
    }
    
    // Function to switch onboarding state and navigate to the next View
    func switchState(){
        withAnimation{
            onboardingState = .profile
        }
    }
}

#Preview(windowStyle: .automatic) {
    OnboardingFeaturesView(onboardingState: .constant(.features))
        .previewVariables()
}
