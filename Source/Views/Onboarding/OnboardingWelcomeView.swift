//
//  OnboardingWelcomeView.swift
//  Arcy
//
//  Created by Matt Novoselov on 02/05/24.
//

import SwiftUI

struct OnboardingWelcomeView: View {
    
    // Binding for controlling current onboarding scene
    @Binding var onboardingState: onboardingState
    
    var body: some View {
        
        VStack{
            Image(.arcyLogoText)
                .interpolation(.high)
                .resizable()
                .scaledToFit()
                .opacity(0.5)
                .frame(height: 20)
            
            Spacer()
            
            Text("Welcome, Explorer")
                .font(.extraLargeTitle)
                .fontWidth(.expanded)
            
            Text("Lorem ipsum")
                .font(.title3)
                .foregroundStyle(.secondary)
            
            Spacer()
            
            Button(action: {switchState()}){
                Text("Continue")
            }
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .padding(.all, 40)
        
    }
    
    func switchState(){
        withAnimation{
            onboardingState = .features
        }
    }
}

#Preview(windowStyle: .automatic) {
    OnboardingWelcomeView(onboardingState: .constant(.welcome))
}
