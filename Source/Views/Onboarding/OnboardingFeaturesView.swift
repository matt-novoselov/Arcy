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
    
    var body: some View {
        VStack(spacing: 20){
            // Main title
            Text("Features")
                .font(.extraLargeTitle)
                .padding()
            
            Spacer()
            
            // Display several onboarding cards with features description
            OnboardingCardView(iconName: "sun.min", title: "Lorem ipsum", description: "Lorem ipsum lorem ipsum orem ipsum")
            
            OnboardingCardView(iconName: "sun.min", title: "Lorem ipsum", description: "Lorem ipsum lorem ipsum orem ipsum")
            
            OnboardingCardView(iconName: "sun.min", title: "Lorem ipsum", description: "Lorem ipsum lorem ipsum orem ipsum")
            
            Spacer()
            
            // Button to switch onboarding state and navigate to the next View
            Button(action: {switchState()}){
                Text("Continue")
            }
        }
        .padding(.all, 40)
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
