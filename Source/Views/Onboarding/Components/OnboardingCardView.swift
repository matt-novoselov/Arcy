//
//  OnboardingCardView.swift
//  Arcy
//
//  Created by Matt Novoselov on 03/05/24.
//

import SwiftUI

// A single card that is visible during onboarding phase
struct OnboardingCardView: View {
    
    // Name of the SF symbol
    let iconName: String
    
    // Title of the card
    let title: String
    
    // Full description of the card
    let description: String
    
    var body: some View {
        
        HStack(spacing: 15){
            // Display SF Symbol
            Image(systemName: iconName)
                .font(.extraLargeTitle)
            
            VStack(alignment: .leading){
                // Display title
                Text(title)
                    .font(.title)
                
                // Display description
                Text(description)
                    .font(.body)
                    .foregroundStyle(.secondary)
                
            }
            
            Spacer()
        }
        .padding(.all, 20)
        
        // Apply glass effect background
        .glassBackgroundEffect()
        
        .clipShape(.capsule)
        
        .transition(.scale)
        
    }
}

#Preview {
    OnboardingCardView(iconName: "sun.min", title: "Lorem ipsum", description: "Lorem ipsum lorem ipsum orem ipsum")
        .previewVariables()
}
