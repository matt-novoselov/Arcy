//
//  OnboardingProfileView.swift
//  Arcy
//
//  Created by Matt Novoselov on 02/05/24.
//

import SwiftUI


struct OnboardingProfileView: View {
    
    @Binding var onboardingState: onboardingState
    
    @AppStorage("userName") var username: String = ""
    
    @State var usernameEmpty: Bool = UserDefaults.standard.string(forKey: "userName")?.isEmpty ?? true
    
    var body: some View {
        
        NavigationStack{
            VStack(spacing: 20){
                
                Text("Let's setup your profile")
                    .font(.title)
                
                ProfileEditView()
                
                Button(action: {
                    // Get onboarding complete value from the user defaults
                    UserDefaults.standard.set(true, forKey: "onboardingCompleted")
                }, label: {
                    Text(usernameEmpty ? "Enter name to continue" : "Continue")
                        .clipped()
                })
                .disabled(usernameEmpty)
                .onChange(of: username){
                    withAnimation{
                        usernameEmpty = username.isEmpty
                    }
                }

            }
        }

    }
}

#Preview(windowStyle: .automatic) {
    OnboardingProfileView(onboardingState: .constant(.profile))
}
