//
//  SettingsView.swift
//  Arcy
//
//  Created by Matt Novoselov on 08/05/24.
//

import SwiftUI

struct SettingsView: View {
    
    // Showing alert before resetting onboarding
    @State private var showAlert: Bool = false
    
    var body: some View {
        
        VStack{
            Spacer()
            
            VStack{
                ZStack {
                    Image("AppIcon/Back/Content")
                        .interpolation(.high)
                        .resizable()
                    Image("AppIcon/Middle/Content")
                        .interpolation(.high)
                        .resizable()
                        .offset(z: 5)
                    Image("AppIcon/Front/Content")
                        .interpolation(.high)
                        .resizable()
                        .offset(z: 10)
                }
                .clipShape(.circle)
                .frame(width: 120, height: 120)

                Text("Arcy")
                    .font(.largeTitle)
                
                Text("\(UIApplication.appVersion ?? "Unknown")")
                    .font(.caption)
                    .foregroundStyle(.secondary)
            }
            
            Spacer()
            
            // Button to reset onboarding
            Button(action: {showAlert = true}, label: {
                Label("Reset onboarding", systemImage: "arrow.counterclockwise")
                    .labelStyle(CenteredLabelStyle())
            })
            
            Spacer()
            
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
}
