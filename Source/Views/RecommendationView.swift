//
//  RecommendationView.swift
//  Arcy
//
//  Created by Matt Novoselov on 03/05/24.
//

import SwiftUI

struct RecommendationView: View {
    
    // Get onboarding complete value from the user defaults
    @AppStorage("onboardingRecommendationCompleted") private var onboardingRecommendationCompleted: Bool = false
    
    // Value that is reverse to onboardingRecommendationCompleted
    @State private var showingRecommendationOnboarding: Bool = true
    
    var body: some View {
        
        ZStack{
            // Display ContentUnavailableView if there are no recommendations
            ContentUnavailableView("No recommendations", systemImage: "sparkle.magnifyingglass", description: Text("Try liking a few artifacts to see recommendations."))
        }
        
        // Present onboarding sheet that explains the purpose of onboarding
        .sheet(isPresented: $showingRecommendationOnboarding) {
            OnboardingRecommendationView()
        }
        
        // Control showingRecommendationOnboarding value
        .onAppear{
            showingRecommendationOnboarding = !onboardingRecommendationCompleted
        }
        .onChange(of: onboardingRecommendationCompleted){
            showingRecommendationOnboarding = !onboardingRecommendationCompleted
        }
        
    }
}

#Preview(windowStyle: .automatic) {
    RecommendationView()
}
