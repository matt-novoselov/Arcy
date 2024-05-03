//
//  OnboardingFeaturesView.swift
//  Arcy
//
//  Created by Matt Novoselov on 03/05/24.
//

import SwiftUI

struct OnboardingFeaturesView: View {
    
    @Binding var onboardingState: onboardingState
    
    var body: some View {
        VStack(spacing: 20){
            Text("Features")
                .font(.extraLargeTitle)
                .padding()
            
            OnboardingCardView(iconName: "sun.min", title: "Lorem ipsum", description: "Lorem ipsum lorem ipsum orem ipsum")
            
            OnboardingCardView(iconName: "sun.min", title: "Lorem ipsum", description: "Lorem ipsum lorem ipsum orem ipsum")
            
            OnboardingCardView(iconName: "sun.min", title: "Lorem ipsum", description: "Lorem ipsum lorem ipsum orem ipsum")
            
            Button(action: {switchState()}){
                Text("Continue")
            }
        }
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
