//
//  Test1.swift
//  Arcy
//
//  Created by Matt Novoselov on 02/05/24.
//

import SwiftUI

enum onboardingState{
    case welcome
    case profile
    case features
}

struct OnboardingView: View {
    
    // Get onboarding complete value from the user defaults
    @AppStorage("onboardingCompleted") var onboardingCompleted: Bool = false
    @State private var startTime = Date.now
    @State var onboardingState: onboardingState = .welcome
    
    var body: some View {
        
        TimelineView(.animation) { timeline in
            let elapsedTime = startTime.distance(to: timeline.date)
            Group{
                switch onboardingState {
                    
                    // Display main game menu
                case .welcome:
                    OnboardingWelcomeView(onboardingState: $onboardingState)
                        .transition(.blurReplace)
                    
                case .profile:
                    OnboardingProfileView(onboardingState: $onboardingState)
                        .transition(.blurReplace)
                    
                case .features:
                    OnboardingFeaturesView(onboardingState: $onboardingState)
                        .transition(.blurReplace)
                }
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            
            .background{
                BackgroundGradientView(elapsedTime: elapsedTime)
            }
            
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
}
