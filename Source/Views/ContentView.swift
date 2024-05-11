//
//  ContentView.swift
//  Arcy
//
//  Created by Matt Novoselov on 20/04/24.
//

import SwiftUI


struct ContentView: View {
    
    // Get onboarding complete value from the user defaults
    @AppStorage("onboardingCompleted") private var onboardingCompleted: Bool = false
    
    // Animated wrapper that states if onboarding is completed
    @State private var animatedOnboardingCompleted: Bool = false
    
    var body: some View {
        
        // Display main view or onboarding based on saved value
        Group{
            if animatedOnboardingCompleted{
                SelectionPageView()
                    .transition(.blurReplace)
            } else{
                OnboardingView()
                    .transition(.blurReplace)
            }
        }
        
        // Animate property of onboardingCompleted
        .onAppear(){
            animatedOnboardingCompleted = onboardingCompleted
        }
        .onChange(of: onboardingCompleted){
            withAnimation{
                animatedOnboardingCompleted = onboardingCompleted
            }
        }
        
    }
    
}

#Preview(windowStyle: .automatic) {
    ContentView()
        .previewVariables()
}
