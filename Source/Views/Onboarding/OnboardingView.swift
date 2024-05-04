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
                Rectangle()
                    .opacity(0.7)
                    .visualEffect { content, proxy in
                        content
                            .colorEffect(
                                ShaderLibrary.sinebow(
                                    .float2(proxy.size),
                                    .float(elapsedTime)
                                )
                            )
                    }
                    .blur(radius: 150.0)
            }
            
            .onAppear(){
            onboardingState = .welcome
            }
            
        }
        
    }

}

#Preview(windowStyle: .automatic) {
    OnboardingView()
}
