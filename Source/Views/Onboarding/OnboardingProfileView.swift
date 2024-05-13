//
//  OnboardingProfileView.swift
//  Arcy
//
//  Created by Matt Novoselov on 02/05/24.
//

import SwiftUI

// Onboarding view to help user setup their profile
struct OnboardingProfileView: View {
    
    // Binding for controlling current onboarding scene
    @Binding var onboardingState: onboardingState
    
    // Value to store username in the user defaults
    @AppStorage("userName") private var userName: String = ""
    
    // Animated property that states if input field for username is empty
    @State private var inputFieldEmpty: Bool = UserDefaults.standard.string(forKey: "userName")?.isEmpty ?? true
    
    var body: some View {
        
        VStack(spacing: 20){
            
            // Main title
            Text("Let's setup your profile")
                .font(.title)
            
            Spacer()
            
            // Display View for editing profile picture and username
            ProfileEditView()
            
            Spacer()
            
            // Button to switch onboarding state and navigate to the next View
            // Button is disabled until the user enters his name
            Button(action: {
                // Set onboarding complete value to the user defaults
                UserDefaults.standard.set(true, forKey: "onboardingCompleted")
            }, label: {
                Text(inputFieldEmpty ? "Enter name to continue" : "Continue")
                    .clipped()
            })
            
            // Disable button if there is no user input
            .disabled(inputFieldEmpty)
            
            // Animate inputFieldEmpty on change of username
            .onChange(of: userName){
                withAnimation{
                    inputFieldEmpty = userName.isEmpty
                }
            }
            
        }
        .padding(.all, 40)
        
    }
}

#Preview(windowStyle: .automatic) {
    OnboardingProfileView(onboardingState: .constant(.profile))
        .previewVariables()
}
