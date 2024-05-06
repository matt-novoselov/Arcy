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
        
        // Timeline for Metal shader effects
        TimelineView(.animation) { timeline in
            
            // Time elapsed since view appear
            // Needed for Metal shader effect
            let elapsedTime = startTime.distance(to: timeline.date)
            
            VStack(spacing: 20){
                Label("AI Recommendations", systemImage: "sparkles")
                    .font(.title)
                
                Spacer()
                
                CircleWaveEffectView()
                    .blur(radius: 5)
                    .padding()
                    .glassBackgroundEffect(in: .circle)
                    .frame(width: 200)
                
                Spacer()
                
                Text("Laborum irure occaecat eiusmod ipsum sunt ipsum ut tempor occaecat aliquip ipsum non.")
                    .foregroundStyle(.secondary)
                
                Spacer()
                
                Button("Lets try!") {
                    UserDefaults.standard.set(true, forKey: "onboardingRecommendationCompleted")
                }
            }
            .padding(.all, 20)
            
            // Add gradient flow background effect
            .background{
                BackgroundGradientView(elapsedTime: elapsedTime)
                    .scaledToFill()
            }
        }
        
    }
}

// Note: Not everything (including some Metal shaders) are working in Previews
// Use simulator
#Preview(windowStyle: .automatic) {
    OnboardingRecommendationView()
}
