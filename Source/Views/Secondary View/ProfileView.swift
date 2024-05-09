//
//  ProfileView.swift
//  Arcy
//
//  Created by Matt Novoselov on 02/05/24.
//

import SwiftUI

struct ProfileView: View {
    
    // User score from user defaults
    @State private var userScore: Int = 0
    
    var body: some View {
        
        VStack{
            Text("\(userScore) xp")
                .contentTransition(.numericText())
                .font(.extraLargeTitle)
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
            // Guess Game View
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
}
