//
//  SettingsView.swift
//  Arcy
//
//  Created by Matt Novoselov on 08/05/24.
//

import SwiftUI

// Settings view contains debug information about the app, as well as legal information, credits and possibility to reset the onboarding
struct SettingsView: View {
    
    // Showing alert before resetting onboarding
    @State private var showAlert: Bool = false
    
    var body: some View {
        
        VStack{
            Spacer()
            
            // Displaying the app icon, composed from Icon Assets
            VStack{
                ZStack {
                    // Back layer of an icon
                    Image("AppIcon/Back/Content")
                        .interpolation(.high)
                        .resizable()
                    
                    // Middle layer, that is slightly shifted
                    Image("AppIcon/Middle/Content")
                        .interpolation(.high)
                        .resizable()
                        .offset(z: 5)
                    
                    // Front layer, that is located in front of every other layer
                    Image("AppIcon/Front/Content")
                        .interpolation(.high)
                        .resizable()
                        .offset(z: 10)
                }
                .clipShape(.circle)
                .frame(width: 120, height: 120)

                // App name
                Text("Arcy")
                    .font(.largeTitle)
                
                // Programmatically get the app version
                Text("\(UIApplication.appVersion ?? "Unknown")")
                    .font(.caption)
                    .foregroundStyle(.secondary)
            }
            
            Spacer()
            
            // Button to reset onboarding
            Button(action: {showAlert = true}, label: {
                Label("Reset Onboarding", systemImage: "arrow.counterclockwise")
                    .labelStyle(CenteredLabelStyle())
            })
            .padding()
            
            // Developed with ❤️ by Matt Novoselov
            DevelopedWithLoveView()
                .padding()
            
            // Legal notice information
            Text("The 3D models featured within the application originate from the Bonn Center for Digital Humanities and are subject to the following licensing terms: Attribution-NonCommercial-NoDerivs (CC BY-NC-ND 4.0), © 2024 Bonn Center for Digital Humanities. These models remain unaltered from their original form and are intended solely for non-commercial purposes.")
                .font(.footnote)
                .foregroundStyle(.tertiary)
        }
        .padding(.all, 30)
        
        .navigationTitle("Settings")
        
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
    SettingsView()
        .previewVariables()
}
