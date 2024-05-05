//
//  RecommendationView.swift
//  Arcy
//
//  Created by Matt Novoselov on 03/05/24.
//

import SwiftUI

struct RecommendationView: View {
    
    // Get onboarding complete value from the user defaults
    @AppStorage("onboardingRecommendationCompleted") var onboardingRecommendationCompleted: Bool = false
    
    @State var showingRecommendationOnboarding: Bool = true
    
    var body: some View {
        
        ContentUnavailableView("No recommendations", systemImage: "sparkle.magnifyingglass", description: Text("Try liking a few artifacts to see recommendations."))
            .sheet(isPresented: $showingRecommendationOnboarding) {
                OnboardingRecommendationView()
            }
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
