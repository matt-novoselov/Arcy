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
        
        VStack(spacing: 20){
            
            // Overlay 2 gradient texts on top of each other to solve SwiftUI rendering bug
            // Note: Structure should be simplified, if the bug will be fixed in the future versions of SwiftUI for VisionOS
            MeetAIAnimatedGradient()
                .padding()
                .padding(.horizontal)
                .background(.thickMaterial, in: .capsule)
                .overlay{
                    MeetAIAnimatedGradient()
                }
            
            Spacer()
            
            // Display description
            Text("Laborum irure occaecat eiusmod ipsum sunt ipsum ut tempor occaecat aliquip ipsum non.")
                .foregroundStyle(.secondary)
                .lineLimit(nil)
            
            Spacer()
            
            Button("Lets try!") {
                // Mark AI onboarding as completed which will result in a sheet being closed
                UserDefaults.standard.set(true, forKey: "onboardingRecommendationCompleted")
            }
        }
        .padding(.all, 20)
        
    }
}

#Preview(windowStyle: .automatic) {
    OnboardingRecommendationView()
        .previewVariables()
}
