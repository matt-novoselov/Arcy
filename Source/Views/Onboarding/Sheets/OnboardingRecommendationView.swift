//
//  OnboardingRecommendationView
//  Arcy
//
//  Created by Matt Novoselov on 05/05/24.
//

import SwiftUI

struct OnboardingRecommendationView: View {
    
    @Environment(\.dismiss) var dismiss
    @AppStorage("onboardingRecommendationCompleted") var onboardingRecommendationCompleted: Bool = false
    @State private var startTime = Date.now
    
    var body: some View {
        
        TimelineView(.animation) { timeline in
            let elapsedTime = startTime.distance(to: timeline.date)
            VStack(spacing: 20){
                Label("AI Recommendations", systemImage: "sparkles")
                    .font(.title)
                
                Spacer()
                
                CircleWave()
                    .blur(radius: 10)
                
                Spacer()
                
                Text("Laborum irure occaecat eiusmod ipsum sunt ipsum ut tempor occaecat aliquip ipsum non.")
                    .foregroundStyle(.secondary)
                
                Spacer()
                
                Button("Lets try!") {
                    onboardingRecommendationCompleted = true
                    dismiss()
                }
            }
            .padding(.all, 20)
            .background{
                BackgroundGradientView(elapsedTime: elapsedTime)
                    .scaledToFill()
            }
        }
        
    }
}

#Preview(windowStyle: .automatic) {
    OnboardingRecommendationView()
}
