//
//  OnboardingRecommendationView
//  Arcy
//
//  Created by Matt Novoselov on 05/05/24.
//

import SwiftUI

struct OnboardingRecommendationView: View {
    
    // Start time of the background gradient effect
    @State private var startTime = Date.now
    
    var body: some View {
        
        VStack(spacing: 20){
            MeetAIAnimatedGradient()
                .padding()
                .padding(.horizontal)
                .background(.thickMaterial, in: .capsule)
                .overlay{
                    MeetAIAnimatedGradient()
                }
            
            Spacer()
            
            Text("Laborum irure occaecat eiusmod ipsum sunt ipsum ut tempor occaecat aliquip ipsum non.")
                .foregroundStyle(.secondary)
                .lineLimit(nil)
            
            Spacer()
            
            Button("Lets try!") {
                UserDefaults.standard.set(true, forKey: "onboardingRecommendationCompleted")
            }
        }
        .padding(.all, 20)
        
    }
}

// Note: Not everything (including some Metal shaders) are working in Previews
// Use simulator
#Preview(windowStyle: .automatic) {
    OnboardingRecommendationView()
}
