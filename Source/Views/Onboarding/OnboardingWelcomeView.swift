//
//  OnboardingWelcomeView.swift
//  Arcy
//
//  Created by Matt Novoselov on 02/05/24.
//

import SwiftUI

struct OnboardingWelcomeView: View {
    
    @Binding var onboardingState: onboardingState
    
    var body: some View {
        
        VStack{
            Text("Arcy")
                .font(.title2)
            
            Spacer()
            
            Text("Welcome, Explorer")
                .font(.extraLargeTitle)
                .fontWidth(.expanded)
            
            Text("Lorem ipsum")
                .font(.title3)
            
            Spacer()
            
            Button(action: {switchState()}){
                Text("Continue")
            }
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .padding()
        
    }
    
    func switchState(){
        withAnimation{
            onboardingState = .features
        }
    }
}

#Preview(windowStyle: .automatic) {
    OnboardingWelcomeView(onboardingState: .constant(.welcome))
}
