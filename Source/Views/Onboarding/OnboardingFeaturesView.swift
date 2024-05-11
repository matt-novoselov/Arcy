//
//  OnboardingFeaturesView.swift
//  Arcy
//
//  Created by Matt Novoselov on 03/05/24.
//

import SwiftUI

struct OnboardingFeaturesView: View {
    
    // Binding for controlling current onboarding scene
    @Binding var onboardingState: onboardingState
    
    var body: some View {
        VStack(spacing: 20){
            Text("Features")
                .font(.extraLargeTitle)
                .padding()
            
            Spacer()
            
            OnboardingCardView(iconName: "sun.min", title: "Lorem ipsum", description: "Lorem ipsum lorem ipsum orem ipsum")
            
            OnboardingCardView(iconName: "sun.min", title: "Lorem ipsum", description: "Lorem ipsum lorem ipsum orem ipsum")
            
            OnboardingCardView(iconName: "sun.min", title: "Lorem ipsum", description: "Lorem ipsum lorem ipsum orem ipsum")
            
            Spacer()
            
            Button(action: {switchState()}){
                Text("Continue")
            }
        }
        .padding(.all, 40)
    }
    
    func switchState(){
        withAnimation{
            onboardingState = .profile
        }
    }
}

#Preview(windowStyle: .automatic) {
    OnboardingFeaturesView(onboardingState: .constant(.features))
}
