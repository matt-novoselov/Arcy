//
//  ProfileView.swift
//  Arcy
//
//  Created by Matt Novoselov on 02/05/24.
//

import SwiftUI

// Profile view displays information about the user, including an amount of gained XP and let's users to edit their profile picture and name
struct ProfileView: View {
    
    // User score from user defaults
    // The number is 0 by default, and being animated to a number of a total XP that user gained
    @State private var userScore: Int = 0
    
    var body: some View {
        
        VStack{
            // Display user score
            Text("\(userScore) xp")
                .contentTransition(.numericText())
                .font(.extraLargeTitle)
            
                // Animate after a slight delay to a number of a total XP that user gained
                .onAppear(){
                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                        withAnimation{
                            userScore = UserDefaults.standard.integer(forKey: "userXpScore")
                        }
                    }
                }
            
            // Present view to edit properties of the profile
            ProfileEditView(showingShimmerOnAppear: true)
        }
        .padding()
        
        .navigationTitle("Profile")
        
        // Toolbar
        .toolbar{
            // Settings
            ToolbarItem(placement: .topBarTrailing){
                NavigationLink(destination: SettingsView()){
                    Label("Settings", systemImage: "gearshape.fill")
                }
            }
        }
        
    }
}

#Preview(windowStyle: .automatic) {
    ProfileView()
        .previewVariables()
}
