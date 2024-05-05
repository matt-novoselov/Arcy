//
//  ProfileView.swift
//  Arcy
//
//  Created by Matt Novoselov on 02/05/24.
//

import SwiftUI

struct ProfileView: View {
    
    @State private var textInput: String = ""
    
    // Get onboarding complete value from the user defaults
    @AppStorage("onboardingCompleted") var onboardingCompleted: Bool = false
    
    @State var showAlert: Bool = false
    
    var body: some View {
        VStack{
            
            Spacer()
            
            ProfileEditView()
            
            Button(action: {showAlert = true}, label: {
                Text("Reset onboarding")
            })
            
            Spacer()
            
            HStack(spacing: 5){
                Text("Developed with")
                
                OneShotLikeButtonView()
                
                Text("by Matt Novoselov")
            }
            .font(.caption)
            .opacity(0.5)
            
            Text("The 3D models featured within the application originate from the Bonn Center for Digital Humanities and are subject to the following licensing terms: Attribution-NonCommercial-NoDerivs (CC BY-NC-ND 4.0), © 2024 Bonn Center for Digital Humanities. These models remain unaltered from their original form and are intended solely for non-commercial purposes.")
                .font(.caption)
                .foregroundStyle(.tertiary)
        }
        .padding()
        .alert(isPresented: $showAlert) {
            Alert(
                title: Text("Are you sure you want to reset onboarding?"),
                message: Text("This action cannot be undone."),
                primaryButton: .destructive(Text("Reset")) {
                    onboardingCompleted = false
                },
                secondaryButton: .cancel()
            )
        }
    }
}

#Preview(windowStyle: .automatic) {
    ProfileView()
}
