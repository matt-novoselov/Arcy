//
//  OnboardingRecommendationView
//  Arcy
//
//  Created by Matt Novoselov on 05/05/24.
//

import SwiftUI

// View that is supposed to introduce user to the AI Recommendations section of the app
// OnboardingRecommendationView is presented as a sheet
struct OnboardingRecommendationView: View {

    var body: some View {
        
        VStack(spacing: 40){
            
            // Overlay 2 gradient texts on top of each other to solve SwiftUI rendering bug
            // Note: Structure should be simplified, if the bug will be fixed in the future versions of SwiftUI for VisionOS
            MeetAIAnimatedGradient()
                .padding()
                .padding(.horizontal)
                .background(.thickMaterial, in: .capsule)
                .overlay{
                    MeetAIAnimatedGradient()
                }

            // Display description
            Text("Discover personalized artifact recommendations powered by a Neural Network. The Artificial Intelligence will suggest artifacts based on the archaeological items you have liked.")
                .font(.headline)
                .foregroundStyle(.secondary)
                .multilineTextAlignment(.leading) // Align text to the leading edge
                .fixedSize(horizontal: false, vertical: true) // Allow text to wrap
                .frame(maxWidth: 480)
            
            Button("Lets try!") {
                // Mark AI onboarding as completed which will result in a sheet being closed
                UserDefaults.standard.set(true, forKey: "onboardingRecommendationCompleted")
            }
        }
        .padding(.all, 20)
        .padding(.vertical, 30)
        
    }
}

#Preview(windowStyle: .automatic) {
    OnboardingRecommendationView()
        .previewVariables()
}
