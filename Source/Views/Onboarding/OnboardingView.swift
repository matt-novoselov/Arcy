//
//  Test1.swift
//  Arcy
//
//  Created by Matt Novoselov on 02/05/24.
//

import SwiftUI

// Define different states of onboarding
enum onboardingState{
    case welcome
    case profile
    case features
}

// OnboardingView is responsible for controlling different states of the onboarding phase
struct OnboardingView: View {
    
    // Get onboarding complete value from the user defaults
    @AppStorage("onboardingCompleted") private var onboardingCompleted: Bool = false
    
    // Start time of the background gradient effect
    @State private var startTime = Date.now
    
    // Control the flow of onboarding
    @State private var onboardingState: onboardingState = .welcome
    
    var body: some View {
        
        // Timeline for Metal shader effects
        TimelineView(.animation) { timeline in
            
            // Time elapsed since view appear
            // Needed for Metal shader effect
            let elapsedTime = startTime.distance(to: timeline.date)
            
            // Control scenes of onboarding
            Group{
                switch onboardingState {
                    
                // Display main game menu
                case .welcome:
                    OnboardingWelcomeView(onboardingState: $onboardingState)
                        .transition(.blurReplace)
                    
                // Display profile setup
                case .profile:
                    OnboardingProfileView(onboardingState: $onboardingState)
                        .transition(.blurReplace)
                  
                // Display view with app features
                case .features:
                    OnboardingFeaturesView(onboardingState: $onboardingState)
                        .transition(.blurReplace)
                }
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            
            // Add gradient background effect
            .background{
                BackgroundGradientView(elapsedTime: elapsedTime)
            }
            
            // Reset current state on onboarding reset
            .onAppear(){
                onboardingState = .welcome
            }
            .onChange(of: onboardingCompleted){
                if onboardingCompleted == false{
                    onboardingState = .welcome
                }
            }
            
        }
    }
    
}

#Preview(windowStyle: .automatic) {
    OnboardingView()
        .previewVariables()
}
