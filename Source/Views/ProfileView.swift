//
//  ProfileView.swift
//  Arcy
//
//  Created by Matt Novoselov on 02/05/24.
//

import SwiftUI

struct ProfileView: View {
    
    // Showing alert before resetting onboarding
    @State private var showAlert: Bool = false
    
    var body: some View {
        
        VStack{
            Spacer()
            
            // Present view to edit properties of the profile
            ProfileEditView(showingShimmerOnAppear: true)
            
            // Button to reset onboarding
            Button(action: {showAlert = true}, label: {
                Text("Reset onboarding")
            })
            
            Spacer()
            
            DevelopedWithLoveView()
                .padding()
            
            // Legal notice information
            Text("The 3D models featured within the application originate from the Bonn Center for Digital Humanities and are subject to the following licensing terms: Attribution-NonCommercial-NoDerivs (CC BY-NC-ND 4.0), © 2024 Bonn Center for Digital Humanities. These models remain unaltered from their original form and are intended solely for non-commercial purposes.")
                .font(.caption)
                .foregroundStyle(.tertiary)
        }
        .padding()
        
        // Showing alert before resetting onboarding
        .alert(isPresented: $showAlert) {
            Alert(
                title: Text("Are you sure you want to reset onboarding?"),
                message: Text("This action cannot be undone."),
                primaryButton: .destructive(Text("Reset")) {
                    UserDefaults.standard.set(false, forKey: "onboardingCompleted")
                    UserDefaults.standard.set(false, forKey: "onboardingRecommendationCompleted")
                },
                secondaryButton: .cancel()
            )
        }
        
    }
}

#Preview(windowStyle: .automatic) {
    ProfileView()
}
