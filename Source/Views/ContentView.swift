//
//  ContentView.swift
//  Arcy
//
//  Created by Matt Novoselov on 20/04/24.
//

import SwiftUI


struct ContentView: View {
    
    // Get onboarding complete value from the user defaults
    @AppStorage("onboardingCompleted") var onboardingCompleted: Bool = false

    @State var animatedOnboardingCompleted: Bool = false


    var body: some View {
        
        Group{
            if animatedOnboardingCompleted{
                ArchiveView()
                    .transition(.blurReplace)
            } else{
                OnboardingView()
                    .transition(.blurReplace)
            }
        }
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
}
