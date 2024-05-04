//
//  OnboardingCardView.swift
//  Arcy
//
//  Created by Matt Novoselov on 03/05/24.
//

import SwiftUI

struct OnboardingCardView: View {
    
    let iconName: String
    let title: String
    let description: String
    
    var body: some View {
        
        HStack(spacing: 15){
            Image(systemName: iconName)
                .font(.extraLargeTitle)
            
            VStack(alignment: .leading){
                Text(title)
                    .font(.title)
                
                Text(description)
                    .font(.body)
            }
        }
        .padding(.all, 20)
        .glassBackgroundEffect()
        
    }
}

#Preview {
    OnboardingCardView(iconName: "sun.min", title: "Lorem ipsum", description: "Lorem ipsum lorem ipsum orem ipsum")
}
