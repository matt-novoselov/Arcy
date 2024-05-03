//
//  ContentView.swift
//  Ancient Archive
//
//  Created by Matt Novoselov on 20/04/24.
//

import SwiftUI

struct ContentView: View {
    
    // Get onboarding complete value from the user defaults
    @AppStorage("onboardingCompleted") var onboardingCompleted: Bool = false

    var body: some View {
        
        Group{
            if onboardingCompleted{
                ArchiveView()
            } else{
                OnboardingView()
            }
        }
        .transition(.blurReplace)

    }
    
}

#Preview(windowStyle: .automatic) {
    ContentView()
}
